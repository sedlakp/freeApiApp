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
    
    private var getCategoriesTask: AnyCancellable?
    
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
    
}
