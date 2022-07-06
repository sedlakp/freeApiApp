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
            VStack(alignment: .center, spacing: 0) {
                Text(api.API)
                    .lineLimit(1)
                    .font(Font.rubik.bold)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom,8)
                Divider().padding(.horizontal)
                
                CapsuleText(text: api.Category, fixedHorizontally: false)
                    .padding(.vertical, 8)
                
                Text(api.Description)
                    .font(Font.rubik.regular)
                    .foregroundColor(.gray)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }.padding(EdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8))
                .background(ContainerRelativeShape().fill(Color(uiColor: .systemBackground)))
        }.padding(4.0)
            .background(Color(uiColor: .systemGray3))
    }
}

struct RandomApiViewSmall_Previews: PreviewProvider {
    static var previews: some View {
        RandomApiViewSmall(api: FreeApi.ExampleApi)
    }
}
