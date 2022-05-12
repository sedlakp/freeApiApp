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
        Text(freeApi.API)
    }
}

struct FreeApiCellView_Previews: PreviewProvider {
    static var previews: some View {
        FreeApiCellView(freeApi: FreeApi.ExampleApi)
    }
}
