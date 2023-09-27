//
//  FeedView.swift
//  MarvelSwiftUI
//
//  Created by egorvedeneev on 26.09.2023.
//

import SwiftUI

struct FeedView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @StateObject var viewModel = FeedViewModel()
    @State var seatchText = ""
    @State var needUpload = false
    @State var minY = CGFloat()
    @State var height = CGFloat()
    @State private var showNetAlert = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                SearchBar(searchText: $viewModel.searchText)
                LazyVStack(spacing: 8) {
                    if viewModel.characters.isEmpty {
                        Text("Nothing found")
                    }
                    
                    ForEach(viewModel.characters) { character in
                        NavigationLink {
                            CharacterPageView(character: character)
                        } label: {
                            FeedCell(character: character)
                        }
                    }
                    
                    if !viewModel.characters.isEmpty {
                        Divider()
                    }
                    
                    ProgressView().onAppear(perform: {
                        viewModel.appendOffset()
                        viewModel.fetchMoreCharacters()
                    })
                }
                .padding()
            }
            .overlay {
//                if viewModel.isLoading {
//                    Color.white.opacity(0.5).ignoresSafeArea()
//                    ProgressView()
//                }
            }
            .onAppear {
                viewModel.isLoading = true
                viewModel.fetchItems()
            }
        }
        .onChange(of: networkMonitor.isConnected) { connection in
            showNetAlert = connection == false
        }
        .alert("Missing Network Connection", isPresented: $showNetAlert ) {}
        
    }
    
    func upload() {
    
    }
}

//#Preview {
//    FeedView()
//}
