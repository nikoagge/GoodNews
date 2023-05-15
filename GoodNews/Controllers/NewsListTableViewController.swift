//
//  NewsListTableViewController.swift
//  GoodNews
//
//  Created by Nikos Angelidis on 15/5/23.
//

import UIKit

final class NewsListTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - UI
extension NewsListTableViewController {
    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
