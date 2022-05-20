//
//  SettingsView.swift
//  free-apis
//
//  Created by Petr Sedlák on 19.05.2022.
//

import SwiftUI
import PopupView

struct SettingsView: View {
    
    @State var showOnboarding = false
    @State private var showDeleteRealmAlert = false
    @State private var showDeletedConfirmation = false
    
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
                 Button("Yes", role: .destructive) {
                     rs.deleteEverything()
                     showDeletedConfirmation = true
                 }
                 Button("No", role: .cancel) { showDeleteRealmAlert = false }
             } message: {
                 Text("This action will delete all favorited APIs and notes added to them!")
             }

        }.popup(isPresented: $showDeletedConfirmation, type: .floater(verticalPadding: 10, useSafeAreaInset: true),position: .top, autohideIn: 2) {
            Text("Favorites deleted")
                .font(Font.rubik.regular)
                .padding(.all, 8)
                .background(.white)
                .cornerRadius(8)
                .shadow(radius: 1)
        }

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
