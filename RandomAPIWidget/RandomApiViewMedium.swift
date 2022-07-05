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
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(api.API)
                        .lineLimit(2)
                        .font(Font.rubik.bold)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    CapsuleText(text: api.Category)
                }
                
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
                }
                
                Text(api.Description)
                    .font(Font.rubik.regular)
                    .foregroundColor(.gray)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }.padding()
        }
    }
}

struct RandomApiViewMedium_Previews: PreviewProvider {
    static var previews: some View {
        RandomApiViewMedium(api: FreeApi.ExampleApi)
    }
}
