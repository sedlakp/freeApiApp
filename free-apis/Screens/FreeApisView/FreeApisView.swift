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
            }.navigationTitle(category ?? "Free APIs")
        } else {
            List(vm.freeApis, id: \.self) { api in
                FreeApiCellView(selectedAPI: $selectedAPI, showPopup: $showAddToFavPopup, freeApi: api)
                    .buttonStyle(PlainButtonStyle())
            }.navigationTitle(category ?? "Free APIs")
                .environmentObject(vm)
                .popup(isPresented: $showAddToFavPopup, closeOnTap: false, closeOnTapOutside: true) {
                    VStack {
                        Text("You can add a note to \(selectedAPI?.API ?? "API")").multilineTextAlignment(.center)
                        TextEditor(text: $noteText)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.black, lineWidth: 1)
                                )
                            .cornerRadius(16)
                        Button {
                            rs.addToFavorites(selectedAPI!, noteText)
                            showAddToFavPopup = false
                            noteText = ""
                            selectedAPI = nil
                        } label: {
                            Text("Add to favorites")
                                .padding()
                                .foregroundColor(.white)
                                .background(.teal)
                                .cornerRadius(9)
                        }

                    }.padding()
                        .frame(width: 300, height: 350)
                        .background(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(.black, lineWidth: 4)
                            )
                        .cornerRadius(30.0)
                        .shadow(radius: 4)
                }
        }

    }
}

struct FreeApisView_Previews: PreviewProvider {
    static var previews: some View {
        FreeApisView()
    }
}
