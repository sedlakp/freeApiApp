//
//  RandomApiViewMedium.swift
//  free-apis
//
//  Created by Petr Sedlák on 05.07.2022.
//

import SwiftUI

struct RandomApiViewMedium: View {
    
    let api: FreeApi
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(api.API)
                        .lineLimit(1)
                        .font(Font.rubik.bold)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    CapsuleText(text: api.Category)
                }.padding(.bottom, 8)
                
                Divider()//.padding(.horizontal)
                
                HStack {
                    if api.HTTPS {
                        Text("HTTPS")
                            .tagText(tagBackground: .green, tagTextColor: .white)
                    }
                
                    if !api.Auth.isEmpty {
                        Text(api.Auth)
                            .tagText(tagBackground: .yellow, tagTextColor: .black)
                    }
                    
                    if api.isCors {
                        Text("CORS")
                            .tagText(tagBackground: .brown, tagTextColor: .white)
                    }
                }.padding(.vertical, 8)
                
                Text(api.Description)
                    .font(Font.rubik.regular)
                    .foregroundColor(.gray)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }.padding(EdgeInsets(top: 16, leading: 16, bottom: 8, trailing: 16))
                .background(ContainerRelativeShape().fill(Color(uiColor: .systemBackground)))
        }.padding(4.0)
           .background(Color(uiColor: .systemGray3))
    }
}

struct RandomApiViewMedium_Previews: PreviewProvider {
    static var previews: some View {
        RandomApiViewMedium(api: FreeApi.ExampleApi)
    }
}
