//
//  ArticleViewModel.swift
//  GoodNews
//
//  Created by Nikos Angelidis on 16/5/23.
//

import Foundation
import RxSwift
import RxCocoa

struct ArticlesListViewModel {
    let articleViewModels: [ArticleViewModel]
}

extension ArticlesListViewModel {
    init(_ articles: [Article]) {
        articleViewModels = articles.compactMap(ArticleViewModel.init)
    }
    
    func articleAt(_ index: Int) -> ArticleViewModel {
        return articleViewModels[index]
    }
}

struct ArticleViewModel {
    let article: Article
    
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    var title: Observable<String> {
        return Observable<String
        >.just(article.title)
    }
        
    var description: Observable<String> {
        return Observable<String>.just(article.description ?? "")
    }
}
