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
        URLRequest.load(resource: ArticlesList.all)
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                if let result = result {
                    self.articles = result.articles
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
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

