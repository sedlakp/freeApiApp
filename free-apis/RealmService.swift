//
//  RealmService.swift
//  free-apis
//
//  Created by Petr Sedlák on 14.05.2022.
//

import Foundation
import RealmSwift
import SwiftUI

struct RealmService: DynamicProperty {
    
    private let realm = try! Realm()
    
    @ObservedResults(FreeApiRLM.self) var favoritedAPIs
    
    func unFavorite(at index: IndexSet) {
        $favoritedAPIs.remove(atOffsets: index)
    }
    
    func apiIsFavorite(_ api: FreeApi) -> Bool {
        return !favoritedAPIs.filter({$0.API == api.API}).isEmpty
    }
    
    
    func addToFavorites(_ api: FreeApi, _ noteText: String) {
        // check if the thing is already in favorites
        
        if !apiIsFavorite(api) {
            
            let rlmApi = api.toRLM()
            rlmApi.noteText = noteText
            $favoritedAPIs.append(rlmApi)
        }
        
    }
    
    func deleteEverything() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
}
