//
//  DetailView.swift
//  TestProjectWithNews
//
//  Created by artem on 28.07.2023.
//

import SwiftUI

struct DetailView: View {
    
    let article: Article
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                
                AuthorText(author: article.author ?? Strings.noAuthot)
                
                TitleView(title: article.title ?? Strings.noTitle)
                
                ImageView(urlImage: article.urlToImage ?? "")
                
                DescriptionText(descriptionText: article.description ?? Strings.noDescription)
                
                SourceId(id: article.source?.id ?? Strings.noId)
                
                SourceName(name: article.source?.name ?? Strings.noName)
                
                HyperlinkView(url: article.url ?? "")
                
                Spacer()
            }
            .padding()
        }
    }
}
