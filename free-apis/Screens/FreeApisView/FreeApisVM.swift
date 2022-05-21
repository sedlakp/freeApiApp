//
//  FreeApisVM.swift
//  free-apis
//
//  Created by Petr Sedlák on 12.05.2022.
//

import Foundation
import SwiftUI
import Combine
import RealmSwift

class FreeApisVM: ObservableObject, DynamicProperty {
    
    @Published var freeApis: [FreeApi] = []
    @Published var selectedTags: Set<FilterTags> = Set<FilterTags>()
    @Published var searchText: String = ""
    
    /// Looks for a string in api's name or its description
    var searchMatch: [FreeApi] {
        return searchText.isEmpty ? filteredApis : filteredApis.filter { $0.API.contains(searchText) || $0.Description.contains(searchText) }
    }
    
    private var filteredApis: [FreeApi] {
        var filtered = freeApis
        // filtering is done three times if the selectedTags has all three cases, ideal would be just one filtering through compound nspredicate
        if selectedTags.contains(.Cors) {
            filtered = filtered.filter{ $0.isCors }
        }
        if selectedTags.contains(.HTTPS) {
            filtered = filtered.filter{ $0.HTTPS }
        }
        if selectedTags.contains(.Auth) {
            filtered = filtered.filter{ !$0.Auth.isEmpty}
        }
        
        return filtered
    }
    
    private var getEntriesTask: AnyCancellable?
    
    /// Func gets all either all api entries available if `category` is nil.
    public func getEntries(for category: String? = nil) {
        
        var requestURL: URL
        
        if let category = category {
            var url = URLComponents(string: "\(BaseApiURL)\(ApiPaths.entries)")!
            let querys = [URLQueryItem(name: "category", value: category)]
            url.queryItems = querys
            requestURL = url.url!
        } else {
            requestURL = URL(string: "\(BaseApiURL)\(ApiPaths.entries)")!
        }
        print(requestURL)
        getEntriesTask = URLSession.shared.dataTaskPublisher(for: requestURL)
            .map { $0.data }
            .decode(type: FreeApisWrap.self, decoder: JSONDecoder())
            .map{ $0.entries }
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \Self.freeApis, on: self)
    }
    
    
}
