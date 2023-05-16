//
//  Article.swift
//  GoodNews
//
//  Created by Nikos Angelidis on 15/5/23.
//

import Foundation

struct ArticlesList: Decodable {
    let articles: [Article]
}

extension ArticlesList {
    static var all: Resource<ArticlesList> = {
        let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2023-04-15&sortBy=publishedAt&apiKey=")!
        
        return Resource(url: url)
    }()
}

struct Article: Decodable {
    let title: String
    let description: String?
}
