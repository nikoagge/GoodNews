//
//  NewsListTableViewController.swift
//  GoodNews
//
//  Created by Nikos Angelidis on 15/5/23.
//

import UIKit
import RxSwift
import RxCocoa

final class NewsListTableViewController: UITableViewController {
    private let disposeBag = DisposeBag()
    private var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

private extension NewsListTableViewController {
    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func fetchNews() {
        let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2023-04-15&sortBy=publishedAt&apiKey=")
        guard let url = url else { return }
        
        Observable.just(url)
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> [Article]? in
                return try? JSONDecoder().decode(ArticlesList.self, from: data).articles
            }.subscribe(onNext: { [weak self] articles in
                if let articles = articles {
                    DispatchQueue.main.async {
                        self?.articles = articles
                        self?.tableView.reloadData()
                    }
                }
            }).disposed(by: disposeBag)
    }
}

// MARK: - TableView
extension NewsListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let articleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell does not exist")
        }
        
        articleTableViewCell.titleLabel.text = articles[indexPath.row].title
        articleTableViewCell.descriptionLabel.text = articles[indexPath.row].description
        
        return articleTableViewCell
    }
}

