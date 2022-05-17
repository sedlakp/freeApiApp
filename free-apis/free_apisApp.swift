//
//  free_apisApp.swift
//  free-apis
//
//  Created by Petr Sedlák on 12.05.2022.
//

import SwiftUI

@main
struct free_apisApp: App {
    
    @State var selection = 0 //to prevent switch of tab after refresh of a view on a non first tab
    
    @AppStorage("completedOnboarding") private var completedOnboarding = false
    
    init() {
        UINavigationBar.appearance().tintColor = .label
        
    }
    
    var body: some Scene {
        WindowGroup {
            if !completedOnboarding {
                OnboardingView()
            } else {
                TabView(selection: $selection) {
                    CategoriesView().tabItem {
                        Label("Categories", systemImage: "list.dash")
                            }.tag(0)
                    FreeApisView().tabItem {
                        Label("All", systemImage: "figure.wave")
                            }.tag(1)
                    FavoriteApisView().tabItem {
                        Label("Favorited", systemImage: "star")
                            }.tag(2)
                }
            }
        }
    }
    
}
