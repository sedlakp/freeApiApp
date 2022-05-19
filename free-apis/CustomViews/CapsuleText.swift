//
//  CapsuleText.swift
//  free-apis
//
//  Created by Petr Sedlák on 19.05.2022.
//

import SwiftUI

struct CapsuleText: View {
    
    let text: String
    
    var body: some View {
        ZStack {
            Capsule(style: .circular).foregroundColor(.teal)
            Text(text)
                .foregroundColor(.white)
                .frame(alignment: .trailing)
                .font(Font.rubik.semiBoldSmall)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }.fixedSize(horizontal: true, vertical: true) // this makes the views dynamic
    }
}

struct CapsuleText_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleText(text: "Hello world")
    }
}
