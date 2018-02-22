//
//  SearchViewController.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 20/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {

    private lazy var contentView = SearchContentView()
    private lazy var viewModel = SearchViewModel()
        
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = "Main"
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.searchForResults(with: "ray")
    }
    
    private func setupTableView() {
        contentView.resultsTableView.dataSource = self
        contentView.resultsTableView.register(SingleSearchResultTableViewCell.self, forCellReuseIdentifier: SingleSearchResultTableViewCell.reuseId)
    }
}

extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20//viewModel.searchResultsViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SingleSearchResultTableViewCell.reuseId, for: indexPath) as? SingleSearchResultTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .blue
        return cell
    }
}
