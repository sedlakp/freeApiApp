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
            return "Onboarding.Welcome".localize()
        case .LightDark:
            return "Onboarding.LightDark".localize()
        case .Features:
            return "Onboarding.Features".localize()
        }
    }
    
    var detailContent: [String] {
        switch self {
        case .Intro:
            return [
                "Onboarding.Welcome.Text".localize()
            ]
        case .LightDark:
            return [
                "Onboarding.LightDark.Text".localize()
            ]
        case .Features:
            return [
                "Onboarding.Features.1".localize(),
                "Onboarding.Features.2".localize(),
                "Onboarding.Features.3".localize(),
                "Onboarding.Features.2".localize(),
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


enum FilterTags: String, CaseIterable {
    case Cors
    case HTTPS
    case Auth
}

extension String {
    func localize() -> Self {
        return NSLocalizedString(self, comment: "")
    }
}
