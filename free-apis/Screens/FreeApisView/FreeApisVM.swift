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

class FreeApisVM: ObservableObject {
    
    @Published var freeApis: [FreeApi] = []
    //@Published var categoryFreeApis: [FreeApi] = [] // I can probably reuse freeApis but this makes it more clear
    
    private var getEntriesTask: AnyCancellable?
   // private var getCategoryEntriesTask: AnyCancellable?
    
    @ObservedResults(FreeApiRLM.self) var favoritedAPIs
    
    
    func addToFavorites(_ api: FreeApi) {
        $favoritedAPIs.append(api.toRLM())
    }
    
    // - MARK: Request to get all free api entries
    
//    public func getEntries() {
//        getEntriesTask = URLSession.shared.dataTaskPublisher(for: URL(string: "\(BaseApiURL)\(ApiPaths.entries)")!)
//            .map { $0.data }
//            .decode(type: FreeApisWrap.self, decoder: JSONDecoder())
//            .map{ $0.entries }
//            .replaceError(with: [])
//            .eraseToAnyPublisher()
//            .receive(on: RunLoop.main)
//            .assign(to: \Self.freeApis, on: self)
//
//    }
    
    // - MARK: request to get api entries
    
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
            .print("1>")
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \Self.freeApis, on: self)
    }
    
    
}
