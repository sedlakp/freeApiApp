//
//  OnboardingPageView.swift
//  free-apis
//
//  Created by Petr Sedlák on 16.05.2022.
//

import SwiftUI

struct OnboardingPageView: View {
    
    @AppStorage("completedOnboarding") private var completedOnboarding = false
    
    let page: OnboardingPageContent
    
    var body: some View {
        VStack {
            Image(systemName: page.image)
                .resizable()
                .scaledToFit()
                .frame(height: 100, alignment: .center)
                .shadow(radius: 2)
            Spacer().frame(width: 40, height: 40)
            Text(page.titleText).font(.largeTitle)
                .shadow(radius: 2)
            Spacer().frame(height: 5)
            switch page {
            case .Intro:
                Text(page.detailContent.first!)
                    //.fixedSize(horizontal: false, vertical: true)
                    //.lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .padding()
            case .Features:
                VStack(alignment: .leading) {
                    ForEach(page.detailContent, id: \.self) { line in
                        HStack {
                            Image(systemName: "sparkles")
                                .scaledToFit()
                                .foregroundColor(.yellow)
                                .shadow(radius: 0.6)
                            Text(line).frame(alignment: .leading)
                        }
                    }
                }.padding()
            }
            
            if page.hasButton {
                Button {
                    //UserDefaults.standard.set(true, forKey: "completedOnboarding")
                    completedOnboarding = true
                } label: {
                    Text("Finish Onboarding")
                        .bold()
                        .padding()
                        .background(.teal)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                        .shadow(radius: 2)
                }

            }
            
        }
    }
}

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView(page: .Features)
    }
}
