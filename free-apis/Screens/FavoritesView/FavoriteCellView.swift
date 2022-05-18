//
//  FavoriteCellView.swift
//  free-apis
//
//  Created by Petr Sedlák on 16.05.2022.
//

import SwiftUI
import RealmSwift

struct FavoriteCellView: View {
    
    @ObservedRealmObject var rlmAPI: FreeApiRLM
    @State var showWebView: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack{
                    Text(rlmAPI.API).font(Font.rubik.bold)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    ZStack {
                        Capsule(style: .circular).foregroundColor(.teal)
                        Text(rlmAPI.Category).foregroundColor(.white).frame(alignment: .trailing).font(Font.rubik.semiBoldSmall).padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    }.fixedSize(horizontal: true, vertical: true) // this makes the views dynamic
                }
                Divider()
                HStack {
                    if rlmAPI.HTTPS {
                        Text("HTTPS")
                            .font(Font.rubik.semiBoldMini)
                            .foregroundColor(.white)
                        .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                        .background(.green)
                        .cornerRadius(3)
                    }
                
                    if !rlmAPI.Auth.isEmpty {
                        Text(rlmAPI.Auth)
                            .font(Font.rubik.semiBoldMini)
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                            .background(.yellow)
                            .cornerRadius(3)
                    }
                    
                    if rlmAPI.isCors {
                        Text("CORS")
                            .font(Font.rubik.semiBoldMini)
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                            .background(.brown)
                            .cornerRadius(3)
                    }
                }

                HStack {
                    Text(rlmAPI.Description).font(Font.rubik.regular)
                        .foregroundColor(.gray)
                    //.lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
            
                HStack(alignment: .top) {
                    
                    // zstack to make the texteditor dynamic height based on the content
                    ZStack {
                        TextEditor(text: $rlmAPI.noteText)
                            .accentColor(Color(uiColor: .label))
                            .font(Font.rubik.regular)
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                            .background(.gray.opacity(0.1))
                            .cornerRadius(12)
                        Text(rlmAPI.noteText).opacity(0)
                            .font(Font.rubik.regular)
                            .padding(EdgeInsets(top: 13, leading: 13, bottom: 13, trailing: 13))
                            .cornerRadius(12)
                    }
                    
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
                        SafariView(url: URL(string: rlmAPI.Link)!)
                            .edgesIgnoringSafeArea([.bottom])
                    }
                    
                }
            }.padding()
            Divider() // replaces the default list cell separator
        }
    }
}

struct FavoriteCellView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteCellView(rlmAPI: FreeApi.ExampleApi.toRLM())
    }
}
