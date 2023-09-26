//
//  CharacterPageView.swift
//  MarvelSwiftUI
//
//  Created by egorvedeneev on 26.09.2023.
//

import SwiftUI
import Kingfisher

struct CharacterPageView: View {
    var character: Character
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            KFImage(URL(string: character.thumbnail.path + ".jpg"))
                .resizable()
                .scaledToFit()
                .frame(height: 400)
            
            VStack(spacing: 10) {
                HStack {
                    Text(character.name).bold()
                    Spacer()
                }
                
                if let description = character.description {
                    if description == "" {
                        HStack {
                            Text("No description")
                            Spacer()
                        }
                    } else {
                        Text(description)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 10)
            Spacer()
        }
    }
}
