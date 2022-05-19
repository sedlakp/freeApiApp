//
//  Constants.swift
//  free-apis
//
//  Created by Petr Sedlák on 12.05.2022.
//

import Foundation
import UIKit

let BaseApiURL = "https://api.publicapis.org"

enum ApiPaths: CustomStringConvertible {
    
    case entries
    case cateogires
    case randomApi
    
    var description: String {
        switch self {
        case .entries:              return "/entries"
        case .cateogires:           return "/categories"
        case .randomApi:            return "/random"
        }
    }
}

enum OnboardingPageContent: CaseIterable {
    case Intro
    case LightDark
    case Features
    
    var hasButton: Bool {
        switch self {
        case .Intro:
            return false
        case .LightDark:
            return false
        case .Features:
            return true
        }
    }
    
    var titleText: String {
        switch self {
        case .Intro:
            return "Welcome"
        case .LightDark:
            return "Light & Dark"
        case .Features:
            return "Features"
        }
    }
    
    var detailContent: [String] {
        switch self {
        case .Intro:
            return [
                "Hello, this app shows a list of public apis to use in your next project."
            ]
        case .LightDark:
            return [
                "Looks nice in both light and dark appearance."
            ]
        case .Features:
            return [
                "Look up APIs based on category or a keyword",
                "Mark your favorite APIs",
                "Add a comment to favorited API",
                "Random API everytime you open the app, so exciting!",
            ]
        }
    }
    
    var image: String {
        switch self {
        case .Intro:
            return "sun.and.horizon"
        case .LightDark:
            return "circle.righthalf.filled"
        case .Features:
            return "seal"
        }
    }
}
