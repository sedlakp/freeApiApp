//
//  FontEx.swift
//  free-apis
//
//  Created by Petr Sedlák on 18.05.2022.
//

import Foundation
import SwiftUI

extension Font {
    
    static let rubik = Rubik()
    
    struct Rubik {
        let regular = Font.custom("Rubik-Regular", size: 14)
        let regularTitle = Font.custom("Rubik-Regular", size: 20)
        let semiBold = Font.custom("Rubik-SemiBold", size: 14)
        let semiBoldMini = Font.custom("Rubik-SemiBold", size: 7)
        let semiBoldSmall = Font.custom("Rubik-SemiBold", size: 10)
        let bold = Font.custom("Rubik-Bold", size: 14)
        let boldBig = Font.custom("Rubik-Bold", size: 28)
        let semiBoldWidget = Font.custom("Rubik-SemiBold", size: 20)
    }
}


extension UIFont {
    static let rubik = Rubik()
    
    struct Rubik {
        let bold = UIFont(name: "Rubik-Bold", size: 18)!
        let regular = UIFont(name: "Rubik-Regular", size: 14)!
    }
}
