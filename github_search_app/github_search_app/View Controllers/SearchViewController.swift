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

final class SearchViewController: BaseViewController {

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
        contentView.resultsTableView.delegate = self
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
        case .loading:
            contentView.showLoadingIndicator()
        case .content:
            contentView.hideLoadingIndicator()
        case .error(let error):
            contentView.hideLoadingIndicator()
            handleResponseError(error)
        }
    }
    
    private func handleResponseError(_ error: Error) {
        handleError(error, presentCompletion: { [weak self] in
            self?.shouldFetchResults = false
        }, actionHandler: {  [weak self] in
            self?.shouldFetchResults = true
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

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = viewModel.searchResultsViewModels.value[indexPath.row]
        
        guard cellViewModel.isSelectable else {
            return
        }
        let userDetailViewModel = UserDetailsViewModel(from: cellViewModel)
        let userDetailsViewController = UserDetailsViewController(viewModel: userDetailViewModel)
        let navigationController = UINavigationController(rootViewController: userDetailsViewController)
        
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
}
