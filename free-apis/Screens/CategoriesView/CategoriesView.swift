//
//  CategoriesView.swift
//  free-apis
//
//  Created by Petr Sedlák on 12.05.2022.
//

import SwiftUI
import PopupView

struct CategoriesView: View {
    
    @ObservedObject var vm = CategoriesVM()
    
    @State private var selectedAPI: FreeApi?
    @State private var showAddToFavPopup: Bool = false
    @State private var noteText: String = ""
    
    var body: some View {
        NavigationView {
            
            if !vm.categories.isEmpty && vm.randomApi != nil {
                
                List {
                    Section(content: {
                        FreeApiCellView(selectedAPI: $selectedAPI, showPopup: $showAddToFavPopup, isDividerShown: false, freeApi: vm.randomApi!)
                            .buttonStyle(PlainButtonStyle())
                            .listRowInsets(EdgeInsets()) // remove default padding, set padding inside the cell instead
                    }, header: {
                        Text("Random API").font(Font.rubik.semiBold)
                    })
                    Section(content: {
                        ForEach(vm.categories, id: \.self) { category in
                            NavigationLink(destination: FreeApisView(category: category)) {
                                Text(category).font(Font.rubik.bold)
                            }
                            
                        }.navigationTitle(Text("FREE APIs"))
                            .navigationBarTitleDisplayMode(.inline)
                    }, header: {
                        Text("Categories").font(Font.rubik.semiBold)
                    } )
                }
                
            } else {
                ProgressView().onAppear {
                    vm.getRandom()
                    vm.getCategories()
                }.navigationTitle(Text("FREE APIs"))
                    .navigationBarTitleDisplayMode(.inline)
            }
        }.environmentObject(vm)
            .sheet(isPresented: $showAddToFavPopup, content: {
                PopupAddToFavsView(selectedAPI: $selectedAPI, noteText: $noteText, showAddToFavPopup: $showAddToFavPopup)
            })
//            .popup(isPresented: $showAddToFavPopup, closeOnTap: false, closeOnTapOutside: true) {
//                PopupAddToFavsView(selectedAPI: $selectedAPI, noteText: $noteText, showAddToFavPopup: $showAddToFavPopup)
//            }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
