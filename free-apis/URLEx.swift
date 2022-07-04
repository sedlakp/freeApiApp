//
//  URLEx.swift
//  free-apis
//
//  Created by Petr Sedlák on 04.07.2022.
//

//https://www.donnywals.com/handling-deeplinks-in-ios-14-with-onopenurl/

import Foundation

// rename to something more general when you think of another usage of this
enum ApiIdentifier: Hashable {
  case api(name: String)
}

extension URL {
    var isDeeplink: Bool {
        return scheme == "free-apis" // matches my-url-scheme://<rest-of-the-url>
    }
    
    var tabIdentifier: TabIdentifier? {
        guard isDeeplink else { return nil }
        switch host {
            case "apis": return .apis
            case "categories": return .categories // matches my-url-scheme://categories/
            case "settings": return .settings // matches my-url-scheme://settings/
            default: return nil
        }
    }
    
  var freeApiName: ApiIdentifier? {
    guard let tabIdentifier = tabIdentifier, pathComponents.count > 1 else { return nil }
    switch tabIdentifier {
        case .apis: return .api(name: pathComponents[1]) // matches my-url-scheme://categories/<item-uuid-here>/
        default: return nil
    }
  }
    
}
