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
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack{
                    Text(freeApi.API).font(Font.rubik.bold)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    ZStack {
                        Capsule(style: .circular).foregroundColor(.teal)
                        Text(freeApi.Category).foregroundColor(.white).frame(alignment: .trailing).font(Font.rubik.semiBoldSmall).padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    }.fixedSize(horizontal: true, vertical: true) // this makes the views dynamic
                }
                Divider()
                HStack {
                    if freeApi.HTTPS {
                        Text("HTTPS")
                            .font(Font.rubik.semiBoldMini)
                            .foregroundColor(.white)
                        .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                        .background(.green)
                        .cornerRadius(3)
                    }
                
                    if !freeApi.Auth.isEmpty {
                        Text(freeApi.Auth)
                            .font(Font.rubik.semiBoldMini)
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                            .background(.yellow)
                            .cornerRadius(3)
                    }
                    
                    if freeApi.isCors {
                        Text("CORS")
                            .font(Font.rubik.semiBoldMini)
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                            .background(.brown)
                            .cornerRadius(3)
                    }
                }

                HStack {
                    Text(freeApi.Description).font(Font.rubik.regular)
                        .foregroundColor(.gray)
                    //.lineLimit(nil)
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
    //                    Image(systemName: "heart.circle.fill")
    //                        .resizable()
    //                        .foregroundColor(.indigo)
    //                        .frame(width: 40, height: 40)
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
