//
//  free_apisApp.swift
//  free-apis
//
//  Created by Petr Sedlák on 12.05.2022.
//

import SwiftUI
import IQKeyboardManagerSwift

@main
struct free_apisApp: App {
    
    @State var selection = 0 //to prevent switch of tab after refresh of a view on a non first tab
    
    @AppStorage("completedOnboarding") private var completedOnboarding = false
    
    init() {
        UINavigationBar.appearance().tintColor = .label
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont.rubik.bold]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.rubik.regular], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.rubik.regular], for: .highlighted)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.rubik.regular], for: .focused)
        
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
                            }.tag(0)
                    FreeApisView().tabItem {
                        Label("All", systemImage: "figure.wave").font(Font.rubik.semiBoldMini)
                            }.tag(1)
                    FavoriteApisView().tabItem {
                        Label("Favorited", systemImage: "star").font(Font.rubik.semiBoldMini)
                            }.tag(2)
                }
            }
        }
    }
    
}
