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

class FreeApisVM: AppViewModel, ObservableObject, DynamicProperty {
    
    @Published var freeApis: [FreeApi] = []
    @Published var selectedTags: Set<FilterTags> = Set<FilterTags>()
    @Published var searchText: String = ""
    
    @Published var showRetry: Bool = false
    
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
    
    // keep the reference to the task, gets reassigned everytime the getEntries function is called
    private var getEntriesTask: AnyCancellable?
    
    // function that only specifies the result type for the generic function
    private func getEntriesRequest(for url: URL) -> AnyPublisher<FreeApisWrap, Error>{
        return getRequest(for: url)
    }
    
    /// Func gets all either all api entries available if `category` is nil.
    /// This function is accessible to the view to trigger the request
    public func getEntries(for category: String? = nil) {
        getEntriesTask = getEntriesRequest(for: category == nil ? ApiPaths.entries.url : ApiPaths.categoryEntries(category!).url)
            .mapError({ [weak self] error -> Error in
                // show retry screen if an error happens, I could also return the error here and show it as a message
                // I could also use closure instead of @Published property if I wanted to do something directly in the FreeApisViewß struct, but this way the logic stays here in VM
                self?.showRetry = true
                return error
            })
            .map{ $0.entries }
            .replaceError(with: [])
            .assign(to: \Self.freeApis, on: self)
    }
    
}
