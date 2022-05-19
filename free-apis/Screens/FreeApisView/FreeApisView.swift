//
//  FreeApisView.swift
//  free-apis
//
//  Created by Petr Sedlák on 12.05.2022.
//

import SwiftUI
import PopupView

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
        } else {
            List(vm.freeApis, id: \.self) { api in
                FreeApiCellView(selectedAPI: $selectedAPI, showPopup: $showAddToFavPopup, freeApi: api)
                    .buttonStyle(PlainButtonStyle())
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets()) // remove default padding, set padding inside the cell instead
            }
            .navigationTitle(Text(category ?? "Free APIs"))
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
