//
//  FreeApisView.swift
//  free-apis
//
//  Created by Petr Sedlák on 12.05.2022.
//

import SwiftUI

struct FreeApisView: View {
    
    @ObservedObject private var vm = FreeApisVM()
    
    var body: some View {
        
        List(vm.freeApis, id: \.self) { api in
            FreeApiCellView(freeApi: api)
        }.onAppear {
            vm.getEntries()
        }
    }
}

struct FreeApisView_Previews: PreviewProvider {
    static var previews: some View {
        FreeApisView()
    }
}
