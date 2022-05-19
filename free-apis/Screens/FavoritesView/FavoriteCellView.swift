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
                    CapsuleText(text: rlmAPI.Category)
                }
                Divider()
                HStack {
                    if rlmAPI.HTTPS {
                        Text("HTTPS")
                            .tagText(tagBackground: .green, tagTextColor: .white)
                    }
                
                    if !rlmAPI.Auth.isEmpty {
                        Text(rlmAPI.Auth)
                            .tagText(tagBackground: .yellow, tagTextColor: .black)
                    }
                    
                    if rlmAPI.isCors {
                        Text("CORS")
                            .tagText(tagBackground: .brown, tagTextColor: .white)
                    }
                }

                HStack {
                    Text(rlmAPI.Description)
                        .font(Font.rubik.regular)
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
            
                HStack(alignment: .top) {
                    
                        TextEditor(text: $rlmAPI.noteText)
                            .accentColor(Color(uiColor: .label))
                            .frame(height: 200)
                            .font(Font.rubik.regular)
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                            .background(.gray.opacity(0.1))
                            .cornerRadius(12)
                    
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
