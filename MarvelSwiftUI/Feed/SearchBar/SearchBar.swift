//
//  SearchBar.swift
//  MarvelSwiftUI
//
//  Created by egorvedeneev on 26.09.2023.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
            TextField("Search", text: $searchText)
        }
        .padding(5)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray, lineWidth: 2)
        }
        .padding(.horizontal, 10)
    }
}
