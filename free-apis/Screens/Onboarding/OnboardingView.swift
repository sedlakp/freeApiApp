//
//  Onboarding.swift
//  free-apis
//
//  Created by Petr Sedlák on 16.05.2022.
//

import SwiftUI

struct OnboardingView: View {
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    var body: some View {
        TabView {
            ForEach(OnboardingPageContent.allCases, id: \.self) { page in
                OnboardingPageView(page: page)
            }
        }.tabViewStyle(.page(indexDisplayMode: .always))
        
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
