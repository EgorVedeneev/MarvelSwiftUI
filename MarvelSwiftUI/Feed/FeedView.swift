//
//  FeedView.swift
//  MarvelSwiftUI
//
//  Created by egorvedeneev on 26.09.2023.
//

import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    @State var characters = [Character]()
    @State var seatchText = ""
    
    var body: some View {
        
        ScrollView {
            SearchBar(searchText: $viewModel.searchText)
            LazyVStack(spacing: 8) {
                if let characters = viewModel.characters {
                    ForEach(characters) {character in
                        FeedCell(character: character)
                    }
                }
                Divider()
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchItems()
        }
        
        .navigationTitle("Characters")
    }
}

#Preview {
    FeedView()
}
