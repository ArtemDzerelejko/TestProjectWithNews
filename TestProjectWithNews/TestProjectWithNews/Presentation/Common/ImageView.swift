//
//  ImageView.swift
//  TestProjectWithNews
//
//  Created by artem on 28.07.2023.
//

import SwiftUI

struct ImageView: View {
    @State var urlImage: String
    var width = UIScreen.main.bounds.width * 0.9 
    var height = UIScreen.main.bounds.height * 0.5

    var body: some View {
        if let imageURL = URL(string: urlImage) {
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay {
                        Rectangle()
                            .stroke(Color.black,lineWidth: 2)
                    }
            } placeholder: {
                Rectangle()
                    .stroke(Color.black,lineWidth: 2)
            }
        } else {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.blue)
                .frame(width: width, height: height) // Використовуємо width і height
        }
    }
}
