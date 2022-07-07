//
//  ArrayEx.swift
//  free-apis
//
//  Created by Petr Sedlák on 07.07.2022.
//

import Foundation

extension Array where Element: Hashable{
    func mostFrequent() -> (value: Element, count: Int)? {
        let counts = self.reduce(into: [:]) { $0[$1, default: 0] += 1 }

        if let (value, count) = counts.max(by: { $0.1 < $1.1 }) {
            return (value, count)
        }
        return nil
    }
}
