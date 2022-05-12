//
//  Constants.swift
//  free-apis
//
//  Created by Petr Sedlák on 12.05.2022.
//

import Foundation


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
