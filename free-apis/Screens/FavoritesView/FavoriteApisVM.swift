//
//  FavoriteApisVM.swift
//  free-apis
//
//  Created by Petr Sedlák on 13.05.2022.
//

import Foundation
import Combine
import RealmSwift

class FavoriteApisVM: ObservableObject {
    
    @ObservedResults(FreeApiRLM.self) var favoritedApis
    
    func unFavorite(at index: IndexSet) {
            $favoritedApis.remove(atOffsets: index)
    }
    
}
