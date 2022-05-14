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
       NavigationView {
           List {
               ForEach(rs.favoritedAPIs) { api in
                   FreeApiCellView(freeApi: api.toNonRLM())
                       .buttonStyle(PlainButtonStyle()) // this makes the cell non selectable, only the buttons are touchable
               }.onDelete(perform: rs.unFavorite)
           }
           .navigationTitle("Favorites")
           .navigationBarTitleDisplayMode(.inline)
           
       }
    }
}

struct FavoriteApisView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteApisView()
    }
}
