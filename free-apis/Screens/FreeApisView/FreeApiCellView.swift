//
//  FreeApiCellView.swift
//  free-apis
//
//  Created by Petr Sedlák on 12.05.2022.
//

import SwiftUI

// I could also use a protocol for FreeApi and FreeApiRLM objects and use just this View to show cells
struct FreeApiCellView: View {
    @EnvironmentObject var vm: FreeApisVM
    
    @Binding var selectedAPI: FreeApi?
    @Binding var showPopup: Bool
    @State var showWebView: Bool = false
    
    var isDividerShown: Bool = true
    
    var rs = RealmService()
    
    let freeApi: FreeApi
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading) {
                HStack {
                    Text(freeApi.API).font(Font.rubik.bold)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    CapsuleText(text: freeApi.Category)
                }
                Divider()
                HStack {
                    if freeApi.HTTPS {
                        Text("HTTPS")
                            .tagText(tagBackground: .green, tagTextColor: .white)
                    }
                
                    if !freeApi.Auth.isEmpty {
                        Text(freeApi.Auth)
                            .tagText(tagBackground: .yellow, tagTextColor: .black)
                    }
                    
                    if freeApi.isCors {
                        Text("CORS")
                            .tagText(tagBackground: .brown, tagTextColor: .white)
                    }
                }

                HStack {
                    Text(freeApi.Description).font(Font.rubik.regular)
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
            
                HStack {
                    Button {
                        //rs.addToFavorites(freeApi)
                        selectedAPI = freeApi
                        showPopup = true
                    } label: {
                        ZStack {
                            Capsule().foregroundColor(.indigo)
                                .frame(height: 40)
                            Image(systemName: "heart.fill").foregroundColor(Color(uiColor:.systemGray5))
                        }
                    }.buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    
                    Button {
                        showWebView.toggle()
                    } label: {
                        Image(systemName: "link.circle.fill")
                            .resizable()
                            .foregroundColor(.orange)
                            .frame(width: 40, height: 40)
                    }
                    .sheet(isPresented: $showWebView) {
                        SafariView(url: URL(string: freeApi.Link)!)
                            .edgesIgnoringSafeArea([.bottom])
                    }
                    
                }
            }.padding()
            if isDividerShown {
                Divider() // replaces the default list cell separator
            }
        }
    }
}

struct FreeApiCellView_Previews: PreviewProvider {
    static var previews: some View {
        FreeApiCellView(selectedAPI: .constant(nil), showPopup: .constant(false), freeApi: FreeApi.ExampleApi)
            .environmentObject(FreeApisVM())
    }
}
