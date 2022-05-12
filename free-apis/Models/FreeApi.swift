//
//  FreeApi.swift
//  free-apis
//
//  Created by Petr Sedlák on 12.05.2022.
//

import Foundation

struct FreeApi: Hashable, Decodable {
    let API: String
    let Description: String
    let Auth: String
    let HTTPS: Bool
    let Cors: String
    let Link: String
    let Category: String
    
    
    static let ExampleApi = FreeApi(API: "Test", Description: "Description", Auth: "what", HTTPS: true, Cors: "idk what this is", Link: "somelink.com", Category: "Dogs")
}

struct FreeApisWrap: Hashable,Decodable {
    let entries: [FreeApi]
    let count: Int
}
