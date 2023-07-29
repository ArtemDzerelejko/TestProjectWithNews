//
//  ModelForNews.swift
//  TestProjectWithNews
//
//  Created by artem on 28.07.2023.
//

import Foundation

struct ModelForNews {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
    
    init(remote: ModelForNewsRemote?) {
        status = remote?.status
        articles = remote?.articles?.compactMap({ articleRemote in
            return Article(source: articleRemote.source,
                           author: articleRemote.author,
                           title: articleRemote.title,
                           description: articleRemote.description,
                           url: articleRemote.url,
                           urlToImage: articleRemote.urlToImage,
                           publishedAt: articleRemote.publishedAt,
                           content: articleRemote.content)
        })
        totalResults = remote?.totalResults
    }
}

struct ArticleObject {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    init(source: Source?, author: String?,
         title: String?,
         description: String?,
         url: String?,
         urlToImage: String?,
         publishedAt: String?,
         content: String?) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}

struct SourceObject {
    let id: String?
    let name: String?
    
    init(id: String?, name: String?) {
        self.id = id
        self.name = name
    }
}
