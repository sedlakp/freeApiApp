//
//  FavoriteCellView.swift
//  free-apis
//
//  Created by Petr Sedlák on 16.05.2022.
//

import SwiftUI

struct FavoriteCellView: View {
    
    let rlmAPI: FreeApiRLM
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack{
                Text(rlmAPI.API).font(Font.system(size: 14))
                Spacer()
                ZStack {
                    Capsule(style: .circular).foregroundColor(.teal)
                    Text(rlmAPI.Category).foregroundColor(.white).frame(alignment: .trailing).font(Font.system(size: 12)).padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                }.fixedSize(horizontal: true, vertical: true) // this makes the views dynamic
            }
            HStack {
                Text(rlmAPI.Description).font(Font.system(size: 11))
                    .foregroundColor(.gray)
                //.lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
            HStack {
                Text(rlmAPI.noteText)
                    .font(Font.system(size: 11))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Link(destination: URL(string: rlmAPI.Link)!) {
                    Image(systemName: "link.circle.fill")
                        .resizable()
                        .foregroundColor(.orange)
                        .frame(width: 40, height: 40)
                }
            }

        }.padding()
    }
}

struct FavoriteCellView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteCellView(rlmAPI: FreeApi.ExampleApi.toRLM())
    }
}
