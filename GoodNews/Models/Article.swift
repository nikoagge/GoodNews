//
//  Article.swift
//  GoodNews
//
//  Created by Nikos Angelidis on 15/5/23.
//

import Foundation

struct ArticlesResponse: Decodable {
    let articles: [Article]
}

extension ArticlesResponse {
    static var all: Resource<ArticlesResponse> = {
        let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2023-04-15&sortBy=publishedAt&apiKey=")!
        
        return Resource(url: url)
    }()
}

struct Article: Decodable {
    let title: String
    let description: String?
}
