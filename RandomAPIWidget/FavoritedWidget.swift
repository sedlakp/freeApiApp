//
//  FavoritedWidget.swift
//  RandomAPIWidgetExtension
//
//  Created by Petr Sedlák on 06.07.2022.
//

import SwiftUI
import WidgetKit

struct FavoritedApiProvider: TimelineProvider {
    
    let vm = FavoritedApiWidgetVM()
    
    func placeholder(in context: Context) -> FavoritedApiEntry {
        
        FavoritedApiEntry(date: Date(), favoritedCount: vm.favoritedCount, favoriteCategory: vm.favoriteCategory)
    }

    func getSnapshot(in context: Context, completion: @escaping (FavoritedApiEntry) -> ()) {
        // during preview the data are needed immediately so use placeholder data
        let entry = FavoritedApiEntry(date: Date(), favoritedCount: vm.favoritedCount, favoriteCategory: vm.favoriteCategory)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        // TODO: read the file shared with the app
        let entry = FavoritedApiEntry(date: Date(), favoritedCount: vm.favoritedCount, favoriteCategory: vm.favoriteCategory)
        
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

// entry for a timeline to be shown in a widget
struct FavoritedApiEntry: TimelineEntry {
    
    // does not have api but either an object or a simple dictionary
    
    let date: Date
    let favoritedCount: Int
    let favoriteCategory: String?
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "free-apis"
        components.host = "favorited"
        return components.url ?? URL(fileURLWithPath: "noUrlError")
    }
}

// handles what should the widget view look like
struct FavoritedAPIWidgetEntryView : View {
    var entry: FavoritedApiEntry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        // manage how a widget looks for a given widget type
        // TODO: Make widget view that shows number of favorited APIs, most common category(if many then show all) and a button to open the app on a favorites tab
        // probably only medium and large widget is applicable
        // button opens the favorited tab, tap anywhere else just opens the app without anything
        switch family {
        case .systemMedium:
            FavoritedViewMedium(entry: entry)
                .widgetURL(entry.url)
        default:
            FavoritedViewMedium(entry: entry)
                .widgetURL(entry.url)
        }
    }
}

struct FavoritedViewMedium: View {
    
    let entry: FavoritedApiEntry

    var body: some View {
        ZStack {
            HStack {
                VStack{
                    Text("Favorited APIs")
                        .font(Font.rubik.bold)
                    Spacer()
                    Text("\(entry.favoritedCount)")
                        .font(Font.rubik.semiBoldWidget)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                        .background(Color(uiColor: .systemGray3))
                        .cornerRadius(15)
                    Spacer()
                }.frame(maxWidth: .infinity)
                
                VStack {
                    Text("Favorite category")
                        .font(Font.rubik.bold)
                    Spacer()
                    CapsuleText(text: entry.favoriteCategory ?? "", fixedHorizontally: false)
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                        .background(Color(uiColor: .systemGray3))
                        .cornerRadius(15)
                    Spacer()
                }.frame(maxWidth: .infinity)
            }
            .padding()
                .background(ContainerRelativeShape().fill(Color(uiColor: .systemBackground)))
        }.padding(4.0)
            .background(Color(uiColor: .systemGray3))
    }
    
}


struct FavoritedAPIWidget: Widget {
    let kind: String = "FavoritedAPIWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: FavoritedApiProvider()) { entry in
            FavoritedAPIWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Favorited APIs")
        .description("Shows number of favorited APIs and favorite category.")
        .supportedFamilies([.systemMedium])
    }
}

struct FavoritedAPIWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FavoritedAPIWidgetEntryView(entry: FavoritedApiEntry(date: Date(), favoritedCount: 2, favoriteCategory: "Animals"))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
        
    }
}


class FavoritedApiWidgetVM: AppViewModel {
    // get the json or plist file with current favorite data
    
    var favoritedCount: Int {
        return AppGroup.apiWidget.userDefaults.integer(forKey: AppGroup.DefaultsKeys.favoritedCount.rawValue)
    }
    
    // If the count of several categories is the same, only the first in line is passed here (set in RealmService file)
    var favoriteCategory: String? {
        return AppGroup.apiWidget.userDefaults.string(forKey: AppGroup.DefaultsKeys.topCategory.rawValue)
    }
    
}
