//
//  EmptyView.swift
//  free-apis
//
//  Created by Petr Sedlák on 19.05.2022.
//

import SwiftUI

struct EmptyView: View {
    
    static let noFavorites: Self = Self(systemImageName: "exclamationmark.triangle", messageText: "You have no favorite APIs, after you add your first one, they will appear here.")
    
    let systemImageName: String
    let messageText: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image(systemName: systemImageName)
                .resizable()
                .scaledToFit()
                .frame(height: 100, alignment: .center)
                .shadow(radius: 2)
            Text(messageText)
                .font(Font.rubik.regular)
                .multilineTextAlignment(.center)
        }.padding(.all, 20)
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView(systemImageName: "star", messageText: "Image of a star")
    }
}
