//
//  ImageView.swift
//  TestProjectWithNews
//
//  Created by artem on 28.07.2023.
//

import SwiftUI

struct ImageView: View {
    
    let urlImage: String
    private let width = UIScreen.main.bounds.width * 0.9
    private let height = UIScreen.main.bounds.height * 0.5
    
    var body: some View {
        if let imageURL = URL(string: urlImage) {
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay {
                        Rectangle()
                            .stroke(Color.black, lineWidth: 2)
                    }
            } placeholder: {
                Rectangle()
            }
        } else {
            Image(systemName: Strings.photo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.blue)
                .frame(width: width, height: height)
        }
    }
}
