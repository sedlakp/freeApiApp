//
//  TagFilterView.swift
//  free-apis
//
//  Created by Petr Sedlák on 20.05.2022.
//

import SwiftUI

struct TagFilterView: View {
    
    @Binding var selectedTags: Set<FilterTags> {
        didSet {
            print(selectedTags)
        }
    }
    
    var body: some View {
        NavigationView {
            List(FilterTags.allCases, id: \.self) { tagName in
                if selectedTags.contains(where: { $0 == tagName}) {
                    Button {
                        selectedTags.remove(tagName)
                    } label: {
                        HStack{
                            Text(tagName.rawValue)
                            Spacer()
                            Image(systemName: "checkmark")
                        }
                    }.foregroundColor(Color(uiColor: .label))

                } else {
                    Button(tagName.rawValue) { selectedTags.insert(tagName) }
                        .foregroundColor(Color(uiColor: .label))
                }
            }
        .navigationTitle("Tag filter")
        .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct TagFilterView_Previews: PreviewProvider {
    static var previews: some View {
        TagFilterView(selectedTags: .constant(Set<FilterTags>()))
    }
}
