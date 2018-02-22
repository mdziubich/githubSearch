//
//  SearchViewController.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 20/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class SearchViewController: UIViewController {

    private lazy var contentView = SearchContentView()
    private lazy var viewModel = SearchViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigatinBar()
        setupTableView()
        setupObservables()
    }
    
    private func setupNavigatinBar() {
        title = "Main"
        extendedLayoutIncludesOpaqueBars = false
        edgesForExtendedLayout = []
    }
    
    private func setupTableView() {
        contentView.resultsTableView.dataSource = self
        contentView.resultsTableView.register(SingleSearchResultTableViewCell.self,
                                              forCellReuseIdentifier: SingleSearchResultTableViewCell.reuseId)
    }
    
    private func setupObservables() {
        contentView.searchInputTextField.rx.text.asObservable()
            .subscribe(onNext: { [weak self] (keyToSearch) in
               self?.viewModel.searchForResults(with: keyToSearch)
            })
            .disposed(by: disposeBag)
        
        viewModel.searchResultsViewModels.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.contentView.resultsTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResultsViewModels.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SingleSearchResultTableViewCell.reuseId, for: indexPath) as? SingleSearchResultTableViewCell else {
            return UITableViewCell()
        }
        let cellViewModel = viewModel.searchResultsViewModels.value[indexPath.row]
        
        cell.setup(with: cellViewModel)
        cell.backgroundColor = .blue //TODO: change
        return cell
    }
}
