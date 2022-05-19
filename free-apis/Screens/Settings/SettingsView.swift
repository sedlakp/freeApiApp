//
//  SettingsView.swift
//  free-apis
//
//  Created by Petr Sedlák on 19.05.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @State var showOnboarding = false
    @State private var showDeleteRealmAlert = false
    
    var rs = RealmService()
    
    var body: some View {
        NavigationView {
            List {
                Button("Show onboarding") {
                    showOnboarding = true
                }
                Button("Delete all favorites") {
                    showDeleteRealmAlert = true
                }
            }.navigationTitle("Settings")
             .navigationBarTitleDisplayMode(.inline)
             .sheet(isPresented: $showOnboarding) {
                    OnboardingView()
             }
             .alert("Delete favorites?", isPresented: $showDeleteRealmAlert) {
                 Button("Yes", role: .destructive) { rs.deleteEverything() }
                 Button("No", role: .cancel) { showDeleteRealmAlert = false }
             } message: {
                 Text("This action will delete all favorited APIs and notes added to them!")
             }

        }

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
