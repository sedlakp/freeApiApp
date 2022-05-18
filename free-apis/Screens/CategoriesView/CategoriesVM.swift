//
//  CategoriesVM.swift
//  free-apis
//
//  Created by Petr Sedlák on 12.05.2022.
//

import Foundation
import SwiftUI
import Combine

class CategoriesVM: ObservableObject {
    
    @Published var categories: [String] = []
    
    @Published var randomApi: FreeApi?
    
    private var getCategoriesTask: AnyCancellable?
    
    private var getRandomTask: AnyCancellable?
    
    public func getCategories() {
        getCategoriesTask = URLSession.shared.dataTaskPublisher(for: URL(string: "\(BaseApiURL)\(ApiPaths.cateogires)")!)
            .map { $0.data }
            .decode(type: CategoriesWrapper.self, decoder: JSONDecoder())
            .map{ $0.categories }
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \Self.categories, on: self)
    }
    
    public func getRandom() {
        getRandomTask = URLSession.shared.dataTaskPublisher(for: URL(string: "\(BaseApiURL)\(ApiPaths.randomApi)")!)
            .map { $0.data }
            .decode(type: FreeApisWrap.self, decoder: JSONDecoder())
            .map{ $0.entries.first }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \Self.randomApi, on: self)
    }
    
}
