//
//  FavoriteApisView.swift
//  free-apis
//
//  Created by Petr Sedlák on 13.05.2022.
//

import SwiftUI

struct FavoriteApisView: View {
    
    @ObservedObject var vm = FavoriteApisVM()
    
    var rs = RealmService()
    
    var body: some View {
       List {
           ForEach(rs.favoritedAPIs) { api in
               Text(api.API)
           }.onDelete(perform: rs.unFavorite)
       }
    }
}

struct FavoriteApisView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteApisView()
    }
}
