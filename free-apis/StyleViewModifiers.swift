//
//  StyleViewModifiers.swift
//  free-apis
//
//  Created by Petr Sedlák on 19.05.2022.
//

import Foundation
import SwiftUI

extension View {
    public func tagText(tagBackground: Color, tagTextColor: Color) -> some View {
        return modifier(TagText(tagBackground: tagBackground, tagTextColor: tagTextColor))
    }
}

fileprivate struct TagText: ViewModifier {
    
    let tagBackground: Color
    let tagTextColor: Color
    
    func body(content: Content) -> some View {
        return content
            .font(Font.rubik.semiBoldMini)
            .foregroundColor(tagTextColor)
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .background(tagBackground)
            .cornerRadius(3)
    }
}


struct AppButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
                .font(Font.rubik.regular)
                .padding()
                .background(.teal)
                .foregroundColor(.white)
                .cornerRadius(14)
                .shadow(radius: 2)
    }
}
