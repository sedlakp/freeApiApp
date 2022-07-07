//
//  AppGroup.swift
//  free-apis
//
//  Created by Petr Sedlák on 06.07.2022.
//

//https://useyourloaf.com/blog/sharing-data-with-a-widget/

import Foundation

public enum AppGroup: String {
    case apiWidget = "group.cz.petrsedlak.ios.apiWidget"

    public var containerURL: URL {
        switch self {
        case .apiWidget:
          return FileManager.default.containerURL(
          forSecurityApplicationGroupIdentifier: self.rawValue)!
        }
    }
    
    public var userDefaults: UserDefaults {
        return UserDefaults(suiteName: self.rawValue)!
    }
    
    public func resetUserDefaults() {
        userDefaults.removeObject(forKey: DefaultsKeys.favoritedCount.rawValue)
        userDefaults.removeObject(forKey: DefaultsKeys.topCategory.rawValue)
    }
    
    enum DefaultsKeys: String {
        case favoritedCount, topCategory
    }
    
}
