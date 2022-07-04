//
//  free_apisApp.swift
//  free-apis
//
//  Created by Petr Sedlák on 12.05.2022.
//

import SwiftUI
import IQKeyboardManagerSwift

// bacause it is hashable, it can be used as a tag for TabView
enum TabIdentifier: Hashable {
  case categories, apis, favorited, settings
}

@main
struct free_apisApp: App {
    
    @State var selection = TabIdentifier.categories //to prevent switch of tab after refresh of a view on a non first tab
    
    @AppStorage("completedOnboarding") private var completedOnboarding = false
    
    init() {
        UIScrollView.appearance().keyboardDismissMode = .onDrag
        
        UINavigationBar.appearance().tintColor = .label
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont.rubik.bold]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.rubik.regular], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.rubik.regular], for: .highlighted)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.rubik.regular], for: .focused)
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    var body: some Scene {
        WindowGroup {
            if !completedOnboarding {
                OnboardingView()
            } else {
                TabView(selection: $selection) {
                    CategoriesView().tabItem {
                        Label("Categories", systemImage: "list.dash").font(Font.rubik.semiBoldMini)
                    }.tag(TabIdentifier.categories)
                    MainFreeApisView().tabItem {
                        Label("All", systemImage: "figure.wave").font(Font.rubik.semiBoldMini)
                    }.tag(TabIdentifier.apis)
                    FavoriteApisView().tabItem {
                        Label("Favorited", systemImage: "star").font(Font.rubik.semiBoldMini)
                    }.tag(TabIdentifier.favorited)
                    SettingsView().tabItem {
                        Label("Settings", systemImage: "gear").font(Font.rubik.semiBoldMini)
                    }.tag(TabIdentifier.settings)
                }.accentColor(Color(uiColor: .label))
                .onOpenURL { url in
                    print("tab url: \(url)")
                    guard let tabIdentifier = url.tabIdentifier else { return }
                    selection = tabIdentifier
                }
            }
        }
    }
    
}
