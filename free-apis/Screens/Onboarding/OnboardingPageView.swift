//
//  OnboardingPageView.swift
//  free-apis
//
//  Created by Petr Sedlák on 16.05.2022.
//

import SwiftUI

struct OnboardingPageView: View {
    
    // using this to dismiss the onboarding when opened from settings
    @Environment(\.presentationMode) var presentationMode
    
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
            Text(page.titleText)
                .font(Font.rubik.regularTitle)
                .shadow(radius: 1)
            Spacer().frame(height: 5)
            switch page {
            case .Intro, .LightDark:
                Text(page.detailContent.first!)
                    .font(Font.rubik.regular)
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
                            Text(line)
                                .font(Font.rubik.regular)
                                .frame(alignment: .leading)
                        }
                    }.padding(.vertical, 3)
                }.padding()
            }
            
            if page.hasButton {
                Button {
                    //UserDefaults.standard.set(true, forKey: "completedOnboarding")
                    completedOnboarding = true
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Onboarding.Finish".localize())
                }.buttonStyle(AppButton())

            }
            
        }
    }
}

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView(page: .Features)
    }
}
