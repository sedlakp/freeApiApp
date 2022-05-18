//
//  CategoriesView.swift
//  free-apis
//
//  Created by Petr Sedlák on 12.05.2022.
//

import SwiftUI

struct CategoriesView: View {
    
    @ObservedObject var vm = CategoriesVM()
    
    var body: some View {
        NavigationView{
            
            if vm.categories.isEmpty {
                ProgressView().onAppear {
                    vm.getCategories()
                }.navigationTitle(Text("Categories"))
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                List(vm.categories, id: \.self) { category in
                    NavigationLink(destination: FreeApisView(category: category)) {
                        Text(category).font(Font.rubik.bold)
                    }
                    
                }.navigationTitle(Text("Categories"))
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
