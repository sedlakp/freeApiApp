//
//  PopupAddToFavsView.swift
//  free-apis
//
//  Created by Petr Sedlák on 17.05.2022.
//

import SwiftUI

struct PopupAddToFavsView: View {
    
    var rs = RealmService()
    
    @Binding var selectedAPI: FreeApi?
    @Binding var noteText: String
    @Binding var showAddToFavPopup: Bool
    
    fileprivate func addToFavorites() {
        rs.addToFavorites(selectedAPI!, noteText)
        showAddToFavPopup = false
        noteText = ""
        selectedAPI = nil
    }
    
    var body: some View {
        VStack {
            Text("You can add a note to \(selectedAPI?.API ?? "API") before adding to favorites")
                .font(Font.rubik.bold)
                .multilineTextAlignment(.center)
            TextEditor(text: $noteText)
                .frame(height: 300) // maybe make dynamic?
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                .accentColor(Color(uiColor: .label))
                .font(Font.rubik.regular)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(uiColor: .label), lineWidth: 1)
                    )
                .cornerRadius(16)
            Button {
                addToFavorites()
            } label: {
                Text("Add to favorites")
            }.buttonStyle(AppButton())
            
            Spacer()
        }.padding()
            .background(Color(UIColor.systemBackground))
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 30)
//                                .stroke(.black, lineWidth: 4)
//                            )
            .cornerRadius(30.0)
            .shadow(radius: 4)
    }
}

struct PopupAddToFavsView_Previews: PreviewProvider {
    static var previews: some View {
        PopupAddToFavsView(selectedAPI: .constant(FreeApi.ExampleApi), noteText: .constant(""), showAddToFavPopup: .constant(true))
    }
}
