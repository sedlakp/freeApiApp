//
//  FreeApisView.swift
//  free-apis
//
//  Created by Petr Sedlák on 12.05.2022.
//

import SwiftUI

struct FreeApisView: View {
    
    @ObservedObject private var vm = FreeApisVM()
    
    var category: String?
    
    var body: some View {
        if vm.freeApis.isEmpty {
            ProgressView().onAppear {
                vm.getEntries(for: category)
            }.navigationTitle(category ?? "Free APIs")
        } else {
            List(vm.freeApis, id: \.self) { api in
                FreeApiCellView(freeApi: api)
            }.navigationTitle(category ?? "Free APIs")
        }

    }
}

struct FreeApisView_Previews: PreviewProvider {
    static var previews: some View {
        FreeApisView()
    }
}
