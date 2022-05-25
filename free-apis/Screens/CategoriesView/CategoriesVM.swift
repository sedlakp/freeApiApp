//
//  CategoriesVM.swift
//  free-apis
//
//  Created by Petr Sedlák on 12.05.2022.
//

import Foundation
import SwiftUI
import Combine

class CategoriesVM: AppViewModel, ObservableObject {
    
    @Published var categories: [String] = []
    
    @Published var randomApi: FreeApi?
    
    private var getCategoriesTask: AnyCancellable?
    
    private var getRandomTask: AnyCancellable?
    
    private func getRandomRequest(for url: URL) -> AnyPublisher<FreeApisWrap, Error> {
        return getRequest(for: url)
    }
    
    private func getCategoriesRequest(for url: URL) -> AnyPublisher<CategoriesWrapper, Error> {
        return getRequest(for: url)
    }
    
    public func getCategories() {
        getCategoriesTask = getCategoriesRequest(for: ApiPaths.cateogires.url)
            .map{ $0.categories }
            .replaceError(with: [])
            .assign(to: \Self.categories, on: self)
    }
    
    public func getRandom() {
        getRandomTask = getRandomRequest(for: ApiPaths.randomApi.url)
            .map{ $0.entries.first }
            .replaceError(with: nil)
            .assign(to: \Self.randomApi, on: self)
    }
    
}
