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
    private var articlesListViewModel: ArticlesListViewModel!
    
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
        URLRequest.load(resource: ArticlesResponse.all)
            .subscribe(onNext: { [weak self] articlesResponse in
                guard let self = self else { return }
                if let articles = articlesResponse?.articles {
                    self.articlesListViewModel = ArticlesListViewModel(articles)
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
        return articlesListViewModel == nil ? 0 : articlesListViewModel.articleViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let articleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell does not exist")
        }
        
        let articleViewModel = articlesListViewModel.articleAt(indexPath.row)
        articleViewModel.title.asDriver(onErrorJustReturn: "")
            .drive(articleTableViewCell.titleLabel.rx.text)
            .disposed(by: disposeBag)
        articleViewModel.description.asDriver(onErrorJustReturn: "")
            .drive(articleTableViewCell.descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        return articleTableViewCell
    }
}

