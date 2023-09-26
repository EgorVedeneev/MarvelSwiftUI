//
//  Model.swift
//  MarvelSwiftUI
//
//  Created by egorvedeneev on 26.09.2023.
//

import Foundation

struct MarvelJSON: Codable {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionText: String?
    var attributionHTML: String?
    var etag: String?
    var data: Data?
}

struct Data: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Result]
}

struct Result: Codable {
    let id: Int
    let name: String
    let description: String?
    let modified: String
    let thumbnail: Thumbnail
    let resourceURI: String
    let comics, series: Comics
    let stories: Stories
    let events: Comics
    let urls: [URLElement]?
}

struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}

struct ComicsItem: Codable {
    let resourceURI: String
    let name: String
}

struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}

struct StoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: String?
}

struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

struct URLElement: Codable {
    let type: String
    let url: String
}
