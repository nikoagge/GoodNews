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

struct Article: Decodable {
    let title: String
    let description: String
}
