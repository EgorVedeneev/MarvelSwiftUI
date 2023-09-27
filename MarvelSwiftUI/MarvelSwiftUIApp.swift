//
//  MarvelSwiftUIApp.swift
//  MarvelSwiftUI
//
//  Created by egorvedeneev on 26.09.2023.
//

import SwiftUI

@main
struct MarvelSwiftUIApp: App {
    @StateObject var networkMonitor = NetworkMonitor()
    var body: some Scene {
        WindowGroup {
            FeedView()
                .environmentObject(networkMonitor)
        }
    }
}
