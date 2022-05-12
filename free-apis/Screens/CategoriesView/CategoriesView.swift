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
            List(vm.categories, id: \.self) { category in
                NavigationLink(destination: FreeApisView(category: category)) {
                    Text(category)
                }
                
            }.onAppear {
                vm.getCategories()
            }
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
