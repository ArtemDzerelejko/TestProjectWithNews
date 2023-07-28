//
//  DetailView.swift
//  TestProjectWithNews
//
//  Created by artem on 28.07.2023.
//

import SwiftUI

import SwiftUI

struct DetailView: View {
    let article: Article

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                
                AuthorText(author: article.author ?? "No authot")
                  
                TitleView(title: article.title ?? "No title")
                
                ImageView(urlImage: article.urlToImage ?? "")
                
                DescriptionText(descriptionText: article.description ?? "No description")
                
            
                Text(article.source?.id ?? "No Id")
                
                Text(article.source?.name ?? "No Name")
                
                HyperlinkView(url: article.url ?? "")
                
                    
                Spacer()
            }
            .padding()
            
        }
        
//        ScrollView {
//
//            VStack(alignment: .leading, spacing: 16) {
//                if let imageURL = URL(string: article.urlToImage ?? "") {
//                    AsyncImage(url: imageURL) { image in
//                        image
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: UIScreen.main.bounds.height * 0.9, height: 200)
//                            .overlay(
//                                Rectangle().foregroundColor(Color.clear)
//                            )
//                    } placeholder: {
//
//                        Rectangle().foregroundColor(Color.clear)
//                    }
//                } else {
//
//                    Image(systemName: "photo")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 200, height: 200)
//                }
//
//                Text(article.title ?? "")
//                    .font(.title)
//                    .foregroundColor(.primary)
//
//                Text(article.description ?? "")
//                    .font(.subheadline)
//
//                Text(article.author ?? "")
//
//
//                Link(destination: URL(string: article.url ?? "")!) {
//                                   Text(article.url ?? "")
//                                       .foregroundColor(.blue)
//                                       .underline()
//                               }
//
//
//                ScrollView {
//                    Text(article.content ?? "")
//                }
//
//                Spacer()
//            }
//            .padding()
//        }
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationTitle(article.title ?? "")
    }
}

