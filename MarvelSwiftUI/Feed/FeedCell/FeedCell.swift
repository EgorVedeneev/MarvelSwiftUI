//
//  FeedCell.swift
//  MarvelSwiftUI
//
//  Created by egorvedeneev on 26.09.2023.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    
    var character: Character
    
    var body: some View {
        VStack {
            Divider()
            HStack {
                ZStack {
                    KFImage(URL(string: character.thumbnail.path + ".jpg"))
                        .placeholder({
                            ZStack {
                                Color.gray.opacity(0.1)
                                ProgressView().tint(.gray)
                            }
                        })
                        .resizable()
                        .scaledToFit()
                }
                .cornerRadius(8)
                .frame(width: 80, height: 80)
                .padding(10)
                
                Text(character.name)
                Spacer()
            }
        }
    }
}

