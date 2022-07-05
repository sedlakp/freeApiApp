//
//  RandomApiViewSmall.swift
//  free-apis
//
//  Created by Petr Sedlák on 05.07.2022.
//

import SwiftUI

struct RandomApiViewSmall: View {
    
    let api: FreeApi
    
    var body: some View {
        ZStack{
            VStack(alignment: .center, spacing: 10) {
                Text(api.API)
                    .lineLimit(2)
                    .font(Font.rubik.bold)
                    .fixedSize(horizontal: false, vertical: true)
                
                Divider().padding(.horizontal)
                
                CapsuleText(text: api.Category, fixedHorizontally: false)
                
                Text(api.Description)
                    .font(Font.rubik.regular)
                    .foregroundColor(.gray)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
            }.padding()
        }
    }
}

struct RandomApiViewSmall_Previews: PreviewProvider {
    static var previews: some View {
        RandomApiViewSmall(api: FreeApi.ExampleApi)
    }
}
