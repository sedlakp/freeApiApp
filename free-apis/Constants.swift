//
//  Constants.swift
//  free-apis
//
//  Created by Petr Sedlák on 12.05.2022.
//

import Foundation
import SwiftUI
import RealmSwift

let BaseApiURL = "https://api.publicapis.org"

enum ApiPaths: CustomStringConvertible {
    
    case entries
    case cateogires
    
    var description: String {
        switch self {
        case .entries:              return "/entries"
        case .cateogires:           return "/categories"
        }
    }
}


struct RealmService: DynamicProperty {
    
    @ObservedResults(FreeApiRLM.self) var favoritedAPIs
    
    func unFavorite(at index: IndexSet) {
        $favoritedAPIs.remove(atOffsets: index)
    }
    
    
    func addToFavorites(_ api: FreeApi) {
        // check if the thing is already in favorites
        
        if favoritedAPIs.filter({$0.API == api.API}).isEmpty {
            $favoritedAPIs.append(api.toRLM())
        }
        
    }
}
