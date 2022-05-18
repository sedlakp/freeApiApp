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
    
    var body: some View {
        VStack {
            Text("You can add a note to \(selectedAPI?.API ?? "API")")
                .font(Font.rubik.bold)
                .multilineTextAlignment(.center)
            TextEditor(text: $noteText)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(uiColor: .label), lineWidth: 1)
                    )
                .cornerRadius(16)
            Button {
                rs.addToFavorites(selectedAPI!, noteText)
                showAddToFavPopup = false
                noteText = ""
                selectedAPI = nil
            } label: {
                Text("Add to favorites")
                    .font(Font.rubik.regular)
                    .padding(EdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 15))
                    .foregroundColor(.white)
                    .background(.teal)
                    .cornerRadius(16)
            }//.frame(height: 20, alignment: .center)

        }.padding()
            .frame(width: 300, height: 350)
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
