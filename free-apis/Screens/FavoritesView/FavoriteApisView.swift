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
                   FavoriteCellView(rlmAPI: api)
                       .buttonStyle(PlainButtonStyle()) // this makes the cell non selectable, only the buttons are touchable
                       .listRowSeparator(.hidden)
                       .listRowInsets(EdgeInsets())
               }.onDelete(perform: rs.unFavorite)
           }
           .navigationTitle(Text("Favorites"))
           .navigationBarTitleDisplayMode(.inline)
           
       }
    }
}

struct FavoriteApisView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteApisView()
    }
}
