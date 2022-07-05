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
    
    var isCors: Bool {
        return self.Cors == "yes"
    }
    
    static let ExampleApi = FreeApi(API: "Chocolate factories", Description: "Worldwide chocolate factory database", Auth: "apiKey", HTTPS: true, Cors: "yes", Link: "somelink.com", Category: "Sweet stuff")
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "free-apis"
        components.host = "apis"
        components.path = "/\(API)"
        return components.url ?? URL(fileURLWithPath: "noUrlError")
    }
}

struct FreeApisWrap: Hashable,Decodable {
    let entries: [FreeApi]
    let count: Int
}
