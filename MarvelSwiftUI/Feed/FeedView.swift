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
        NavigationView {
            ScrollView {
                SearchBar(searchText: $viewModel.searchText)
                LazyVStack(spacing: 8) {
                    if let characters = viewModel.characters {
                        
                        if characters.isEmpty {
                            Text("Nothing found")
                        }
                        
                        ForEach(characters) {character in
                            NavigationLink {
                                CharacterPageView(character: character)
                            } label: {
                                FeedCell(character: character)
                            }
                        }
                        
                        if !characters.isEmpty {
                            Divider()
                        }
                    }
                    
                    
                }
                .padding()
            }
            .overlay {
                if viewModel.isLoading {
                    Color.white.opacity(0.5).ignoresSafeArea()
                    ProgressView()
                }
            }
            .onAppear {
                viewModel.isLoading = true
                viewModel.fetchItems()
            }
        }
        .navigationTitle("Characters")
    }//Hulk
}

#Preview {
    FeedView()
}
