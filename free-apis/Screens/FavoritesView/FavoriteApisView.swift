//
//  FavoriteApisView.swift
//  free-apis
//
//  Created by Petr Sedlák on 13.05.2022.
//

import SwiftUI

struct FavoriteApisView: View {
    
    @ObservedObject var vm = FavoriteApisVM()
    
    var body: some View {
       List {
           ForEach(vm.favoritedApis) { api in
               Text(api.API)
           }.onDelete(perform: vm.unFavorite)
       }
    }
}

struct FavoriteApisView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteApisView()
    }
}
