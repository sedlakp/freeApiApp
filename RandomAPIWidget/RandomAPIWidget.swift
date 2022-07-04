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
struct Provider: TimelineProvider {
    
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
            RandomApiView(api: entry.api)
                .widgetURL(entry.api.url)
        default:
            RandomApiView(api: entry.api)
                .widgetURL(entry.api.url)
        }
    }
}

struct RandomApiView: View {
    
    let api: FreeApi
    
    var body: some View {
        ZStack{
            VStack(alignment: .center, spacing: 10) {
                Text(api.API)
                    .lineLimit(2)
                    .font(Font.rubik.bold)
                    .fixedSize(horizontal: false, vertical: true)
                
                Divider().padding(.horizontal)
                
                CapsuleText(text: api.Category, fixedHorizontally: false)
                
                Text(api.Description)
                    .font(Font.rubik.regular)
                    .foregroundColor(.gray)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                
            }.padding()
        }
    }
}

// main widget manager
@main
struct RandomAPIWidget: Widget {
    let kind: String = "RandomAPIWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            RandomAPIWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Random API")
        .description("Shows a random public API for your next project. Changes every day.")
    }
}

struct RandomAPIWidget_Previews: PreviewProvider {
    static var previews: some View {
        RandomAPIWidgetEntryView(entry: RandomApiEntry(date: Date(), api: FreeApi.ExampleApi))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
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
