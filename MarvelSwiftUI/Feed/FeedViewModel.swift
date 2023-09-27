//
//  FeedViewModel.swift
//  MarvelSwiftUI
//
//  Created by egorvedeneev on 26.09.2023.
//

import Foundation
import Combine
import Alamofire

class FeedViewModel: ObservableObject {
    @Published var feed = MarvelJSON()
    @Published var characters: [Character] = []
    @Published var searchText = ""
    @Published var isLoading = false
    @Published var offset: Int = 0

    private let url = URL(string: Const.urlString)
    private let ts = Date().timeStamp

    var searchCancallable: AnyCancellable? = nil

    init() {
        searchCancallable = $searchText
            .removeDuplicates()
            .debounce(for: 1.0, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str == "" {
                    self.fetchItems()
                } else {
                    self.searchCharacters()
                }
            })
    }
    
    private func createHash() -> String {
        let hash = "\(ts + Const.privateKey + Const.publicKey)"
        let md5Hash = hash.md5
        return md5Hash
    }
    
    public func appendOffset() {
        offset = characters.count
    }

    public func searchCharacters() {
        isLoading = true
        let hash = createHash()
        
        let parameters = [
            "nameStartsWith" : "\(searchText)",
            "ts" : "\(ts)",
            "apikey" : "\(Const.publicKey)",
            "hash" : "\(hash)",
        ]
        
        guard let url = url else { return }
        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .response { response in
                switch response.result {
                case .failure(let error):
                    print(error)
                    
                case .success:
                    guard let data = response.data else { return }
                    let decoder = JSONDecoder()
                    let results = try! decoder.decode(MarvelJSON.self, from: data)
                    guard let characters = results.data?.results else { return }
                    self.characters = characters
                    self.isLoading = false
                }
        }
    }

    
    public func fetchItems() {
        isLoading = true
        let hash = createHash()
        let parameters = [
            "limit": "\(10)",
            "ts" : "\(ts)",
            "apikey" : "\(Const.publicKey)",
            "hash" : "\(hash)",
        ]
        
        guard let url = url else { return }
        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .response { response in
                switch response.result {
                case .failure(let error):
                    print(error)
                    
                case .success:
                    guard let data = response.data else { return }
                    let decoder = JSONDecoder()
                    let results = try! decoder.decode(MarvelJSON.self, from: data)
                    guard let characters = results.data?.results else { return }
                    self.characters = characters
                    self.isLoading = false
                }
        }
    }
    
    public func fetchMoreCharacters() {
        let hash = createHash()
        let parameters = [
            "limit": "\(10)",
            "ts" : "\(ts)",
            "apikey" : "\(Const.publicKey)",
            "hash" : "\(hash)",
            "offset": "\(offset)",
        ]
        
        guard let url = url else { return }
        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .response { response in
                switch response.result {
                case .failure(let error):
                    print(error)
                    
                case .success:
                    guard let data = response.data else { return }
                    let decoder = JSONDecoder()
                    let results = try! decoder.decode(MarvelJSON.self, from: data)
                    guard let characters = results.data?.results else { return }
                    self.characters.append(contentsOf: characters)
            }
        }
    }
}
