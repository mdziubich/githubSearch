//
//  SearchViewModel.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 20/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import RxSwift

final class SearchViewModel {
    
    private lazy var searchService = GithubSearchService()
    
    var searchResultsViewModels = Variable<[SingleSearchResultViewModel]>([SingleSearchResultViewModel]())
    var error = Variable<Error?>(nil)
    
    func searchForResults(with key: String?) {
        guard let textSearch = key else {
            clearSearchedUsersAndRepos()
            return
        }
        
        searchService.searchForUsersAndRepo(by: textSearch) { [weak self] (searchedUsers, searchedRepos, error) in
            self?.error.value = error
            
            var resultsToDisplay = [SingleSearchResultViewModel]()
            if let users = searchedUsers?.users {
                resultsToDisplay = SingleSearchResultViewModel.searchResultViewModels(from: users)
            }
            if let repos = searchedRepos?.repos {
                resultsToDisplay.append(contentsOf: SingleSearchResultViewModel.searchResultViewModels(from: repos))
            }
            
            let resultsSortedById = resultsToDisplay.sorted { $0.id < $1.id }
            
            self?.searchResultsViewModels.value = resultsSortedById
        }
    }
    
    private func csdlearSearchedUsersAndRepos() {
        searchResultsViewModels.value.removeAll()
    }
}
