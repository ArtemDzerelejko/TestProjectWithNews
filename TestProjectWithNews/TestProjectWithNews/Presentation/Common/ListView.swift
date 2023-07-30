//
//  ListView.swift
//  TestProjectWithNews
//
//  Created by artem on 29.07.2023.
//

import SwiftUI

struct ListView: View {
    
    private let article: [Article]
    
    init(article: [Article]) {
        self.article = article
    }
    
    var body: some View {
        List(article, id: \.title) { article in
            NavigationLink {
                DetailView(article: article)
            } label: {
                VStack(alignment: .leading) {
                    TitleView(title: article.title ?? "")
                    DescriptionText(descriptionText: article.description ?? "")
                }
                .padding()
            }
        }
        .listStyle(.plain)
    }
}
