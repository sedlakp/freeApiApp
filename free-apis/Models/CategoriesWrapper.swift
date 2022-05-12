//
//  CategoriesWrapper.swift
//  free-apis
//
//  Created by Petr Sedlák on 12.05.2022.
//

import Foundation

struct CategoriesWrapper: Hashable, Decodable {
    let count: Int
    let categories: [String]
}
