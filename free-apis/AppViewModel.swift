//
//  AppViewModel.swift
//  free-apis
//
//  Created by Petr Sedlák on 24.05.2022.
//

import Foundation
import Combine

// https://www.swiftbysundell.com/articles/creating-generic-networking-apis-in-swift/

class AppViewModel {
    func getRequest<T: Decodable>(for url: URL, timeout: RunLoop.SchedulerTimeType.Stride = 8) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .timeout(timeout, scheduler: RunLoop.main, customError: { return URLError(.timedOut) }) // A timeout to throw an error if the loading takes too long
            .tryMap({ data, response -> Data in
                // if the timeout happens it does not go through here
                // throw error if not 200
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw APIErrors.RequestFailedError
                }
                return data
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
