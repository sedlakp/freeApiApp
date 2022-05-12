//
//  FreeApisVM.swift
//  free-apis
//
//  Created by Petr Sedlák on 12.05.2022.
//

import Foundation
import SwiftUI
import Combine

class FreeApisVM: ObservableObject {
    
    @Published var freeApis: [FreeApi] = []
    
    private var getEntriesTask: AnyCancellable?
    
    public func getEntries() {
        getEntriesTask = URLSession.shared.dataTaskPublisher(for: URL(string: "\(BaseApiURL)\(ApiPaths.entries)")!)
            .map { $0.data }
            .decode(type: FreeApisWrap.self, decoder: JSONDecoder())
            .map{ $0.entries }
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \FreeApisVM.freeApis, on: self)
            
    }
    
    
}
