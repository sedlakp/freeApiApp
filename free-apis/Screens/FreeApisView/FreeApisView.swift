//
//  FreeApisView.swift
//  free-apis
//
//  Created by Petr Sedlák on 12.05.2022.
//

import SwiftUI
import PopupView


struct MainFreeApisView: View {
    var body: some View {
        return NavigationView {
            FreeApisView()
        }
    }
}

struct FreeApisView: View {
    
    @State private var selectedAPI: FreeApi?
    @State private var showAddToFavPopup: Bool = false
    @State private var noteText: String = ""
    
    @ObservedObject private var vm = FreeApisVM()
    
    var rs = RealmService()
    
    var category: String?
    
    var body: some View {
        if vm.freeApis.isEmpty {
            ProgressView().onAppear {
                vm.getEntries(for: category)
            }.navigationTitle(Text(category ?? "Free APIs"))
             .navigationBarTitleDisplayMode(.inline)
        } else {
            List(vm.searchMatch, id: \.self) { api in
                FreeApiCellView(selectedAPI: $selectedAPI, showPopup: $showAddToFavPopup, freeApi: api)
                    .buttonStyle(PlainButtonStyle())
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets()) // remove default padding, set padding inside the cell instead
            }
            .searchable(text: $vm.searchText, prompt: "Search by a keyword")
            .navigationTitle(Text(category ?? "Free APIs"))//not visible if not wrapped inside a navigation view
            .navigationBarTitleDisplayMode(.inline)
                .environmentObject(vm)
                .sheet(isPresented: $showAddToFavPopup, content: {
                    PopupAddToFavsView(selectedAPI: $selectedAPI, noteText: $noteText, showAddToFavPopup: $showAddToFavPopup)
                })
        }

    }
}

struct FreeApisView_Previews: PreviewProvider {
    static var previews: some View {
        FreeApisView()
    }
}
