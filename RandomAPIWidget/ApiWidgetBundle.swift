//
//  ApiWidgetBundle.swift
//  RandomAPIWidgetExtension
//
//  Created by Petr Sedlák on 06.07.2022.
//

import WidgetKit
import SwiftUI

@main
struct ApiWidgetBundle: WidgetBundle {
  var body: some Widget {
    RandomAPIWidget()
    FavoritedAPIWidget()
  }
}
