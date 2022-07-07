//
//  RandomAPIWidget.swift
//  RandomAPIWidget
//
//  Created by Petr Sedlák on 03.07.2022.
//

import WidgetKit
import SwiftUI
import Combine

// provider supplies entries (time and data) to be shown in a widget view at a specific time and events(e.g. preview, normal widget state, placeholder when things are loading)
struct RandomApiProvider: TimelineProvider {
    
    let vm = RandomApiWidgetVM()
    
    func placeholder(in context: Context) -> RandomApiEntry {
        RandomApiEntry(date: Date(), api: FreeApi.ExampleApi)
    }

    func getSnapshot(in context: Context, completion: @escaping (RandomApiEntry) -> ()) {
        // during preview the data are needed immediately so use placeholder data
        if context.isPreview {
            let entry = RandomApiEntry(date: Date(), api: FreeApi.ExampleApi)
            completion(entry)
        } else {
            vm.getRandom { freeApi in
                let entry = RandomApiEntry(date: Date(), api: freeApi ?? FreeApi.ExampleApi)
                completion(entry)
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        // reload new random api each day midnight
        
        // get current date, and calculate start and end of today
        let currentDate = Date()
        let startOfDay = Calendar.current.startOfDay(for: currentDate)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        
        // create entry for timeline
        vm.getRandom { freeApi in
            let entry = RandomApiEntry(date: startOfDay, api: freeApi ?? FreeApi.ExampleApi)
            // there is only one entry, and the timeline gets reset at midnight
            let timeline = Timeline(entries: [entry], policy: .after(endOfDay))
            completion(timeline)
        }
    }
}

// entry for a timeline to be shown in a widget
struct RandomApiEntry: TimelineEntry {
    let date: Date
    let api: FreeApi
}

// handles what should the widget view look like
struct RandomAPIWidgetEntryView : View {
    var entry: RandomApiEntry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        // manage how a widget looks for a given widget type
        // TODO: - Various sizes and designs of the widget
        switch family {
        case .systemSmall:
            RandomApiViewSmall(api: entry.api)
                .widgetURL(entry.api.url)
        case .systemMedium:
            RandomApiViewMedium(api: entry.api)
                .widgetURL(entry.api.url)
        default:
            RandomApiViewMedium(api: entry.api)
                .widgetURL(entry.api.url)
        }
    }
}

struct RandomAPIWidget: Widget {
    let kind: String = "RandomAPIWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: RandomApiProvider()) { entry in
            RandomAPIWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Random API")
        .description("Shows a random public API for your next project. Changes every day.")
        .supportedFamilies([.systemSmall,.systemMedium])
    }
}

struct RandomAPIWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RandomAPIWidgetEntryView(entry: RandomApiEntry(date: Date(), api: FreeApi.ExampleApi))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            RandomAPIWidgetEntryView(entry: RandomApiEntry(date: Date(), api: FreeApi.ExampleApi))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            RandomAPIWidgetEntryView(entry: RandomApiEntry(date: Date(), api: FreeApi.ExampleApi))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
        
    }
}

class RandomApiWidgetVM: AppViewModel {
    
    private var getRandomTask: AnyCancellable?
    
    private func getRandomRequest(for url: URL) -> AnyPublisher<FreeApisWrap, Error> {
        return getRequest(for: url)
    }
    
    public func getRandom(completion: @escaping (FreeApi?) -> ()) {
        getRandomTask = getRandomRequest(for: ApiPaths.randomApi.url)
            .map{ $0.entries.first }
            .replaceError(with: nil)
            .sink(receiveValue: { api in
                completion(api)
            })
    }
}
