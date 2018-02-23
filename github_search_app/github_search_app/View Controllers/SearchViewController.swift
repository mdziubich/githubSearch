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
    private var shouldFetchResults = true
    
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
        contentView.resultsTableView.addInfiniteScroll { [weak self] (_) -> Void in
            self?.viewModel.fetchMoreResults()
        }
        contentView.resultsTableView.setShouldShowInfiniteScrollHandler { [weak self] _ in
            return self?.viewModel.canFetchMoreResults ?? false
        }
    }
    
    private func setupObservables() {
        contentView.searchInputTextField.rx.text.asObservable()
            .subscribe(onNext: { [weak self] (keyToSearch) in
                if let shouldFetchResults = self?.shouldFetchResults,
                    shouldFetchResults {
                    self?.viewModel.searchForResults(with: keyToSearch)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.searchResultsViewModels.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.contentView.resultsTableView.reloadData()
                self?.contentView.resultsTableView.finishInfiniteScroll(completion: nil)
            })
            .disposed(by: disposeBag)
        
        viewModel.loadingState.asObservable()
            .subscribe(onNext: handleLoading)
            .disposed(by: disposeBag)
    }
    
    private func handleLoading(state: LoadingState) {
        switch state {
        case .initial:
            return
        case .loading:
            contentView.showLoadingIndicator()
        case .content:
            contentView.hideLoadingIndicator()
        case .error(let error):
            contentView.hideLoadingIndicator()
            handleError(error)
        }
    }
    
    private func handleError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { [weak self] _ in
            self?.shouldFetchResults = true
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: { [weak self] in
            self?.shouldFetchResults = false
        })
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
        return cell
    }
}
