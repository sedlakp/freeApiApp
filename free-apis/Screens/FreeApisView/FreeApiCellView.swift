//
//  FreeApiCellView.swift
//  free-apis
//
//  Created by Petr Sedlák on 12.05.2022.
//

import SwiftUI

struct FreeApiCellView: View {
    
    let freeApi: FreeApi
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text(freeApi.API).font(Font.system(size: 14))
                Spacer()
                Text(freeApi.Category).frame(alignment: .trailing).font(Font.system(size: 14))
            }
            HStack {
                Text(freeApi.Description).font(Font.system(size: 8))
                //.lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                Link("Visit", destination: URL(string: freeApi.Link)!)

            }
        }.padding()
    }
}

struct FreeApiCellView_Previews: PreviewProvider {
    static var previews: some View {
        FreeApiCellView(freeApi: FreeApi.ExampleApi)
    }
}
