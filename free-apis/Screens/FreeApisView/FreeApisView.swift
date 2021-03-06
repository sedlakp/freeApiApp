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
        return FreeApisView()
    }
}

// The public api list does not change often so refresh does not make sense
struct FreeApisView: View {
    
    @State private var selectedAPI: FreeApi?
    @State private var showAddToFavPopup: Bool = false
    @State private var showFilterPopup: Bool = false
    @State private var noteText: String = ""
    
    @ObservedObject private var vm = FreeApisVM()
    
    var rs = RealmService()
    
    var category: String?
    
    var body: some View {
        NavigationView {
            if vm.showRetry {
                VStack(alignment: .center, spacing: 20) {
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100, alignment: .center)
                        .shadow(radius: 2)
                    Text("Could not get list of APIs").font(Font.rubik.regular)
                    Button {
                        //vm.getEntries(for: category) // not needed because after show retry is set to false the empty screen appears, triggering the request
                        vm.showRetry = false
                    } label: {
                        Text("Try Again")
                    }.buttonStyle(AppButton())
                }

            } else if vm.freeApis.isEmpty {
                ProgressView().onAppear {
                    vm.getEntries(for: category)
                }.navigationTitle(Text(category ?? "Public APIs"))
                 .navigationBarTitleDisplayMode(.inline)
            } else {
                List(vm.searchMatch, id: \.self) { api in
                    FreeApiCellView(selectedAPI: $selectedAPI, showPopup: $showAddToFavPopup, freeApi: api)
                        .buttonStyle(PlainButtonStyle())
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets()) // remove default padding, set padding inside the cell instead
                }
                    .searchable(text: $vm.searchText, prompt: "Search by a keyword")
                    .navigationTitle(Text(category ?? "Public APIs"))//not visible if not wrapped inside a navigation view
                    .navigationBarTitleDisplayMode(.inline)
                    .environmentObject(vm)
                    .sheet(isPresented: $showAddToFavPopup, content: {
                        PopupAddToFavsView(selectedAPI: $selectedAPI, noteText: $noteText, showAddToFavPopup: $showAddToFavPopup)
                    })
                    .toolbar(content: {
                        Button {
                            showFilterPopup = true
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                        }
                    })
                    .sheet(isPresented: $showFilterPopup) {
                        TagFilterView(selectedTags: $vm.selectedTags)
                    }
            }
        }.onOpenURL { url in
            //change the search term to the name of the api
            if case .api(name: let name) = url.freeApiName {
                print("name: \(name)")
                vm.searchText = name
            }
        }
    }
}

struct FreeApisView_Previews: PreviewProvider {
    static var previews: some View {
        FreeApisView()
    }
}
