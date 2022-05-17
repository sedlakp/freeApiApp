//
//  FreeApiCellView.swift
//  free-apis
//
//  Created by Petr Sedlák on 12.05.2022.
//

import SwiftUI

struct FreeApiCellView: View {
    @EnvironmentObject var vm: FreeApisVM
    
    @Binding var selectedAPI: FreeApi?
    @Binding var showPopup: Bool
    @State var showWebView: Bool = false
    
    var rs = RealmService()
    
    let freeApi: FreeApi
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text(freeApi.API).font(Font.system(size: 14))
                Spacer()
                ZStack {
                    Capsule(style: .circular).foregroundColor(.teal)
                    Text(freeApi.Category).foregroundColor(.white).frame(alignment: .trailing).font(Font.system(size: 12)).padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                }.fixedSize(horizontal: true, vertical: true) // this makes the views dynamic
            }
            HStack {
                Text(freeApi.Description).font(Font.system(size: 11))
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
                        Image(systemName: "heart.fill").foregroundColor(.white)
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
    }
}

struct FreeApiCellView_Previews: PreviewProvider {
    static var previews: some View {
        FreeApiCellView(selectedAPI: .constant(nil), showPopup: .constant(false), freeApi: FreeApi.ExampleApi)
            .environmentObject(FreeApisVM())
    }
}
