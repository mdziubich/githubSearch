//
//  SearchViewModel.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 20/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import RxSwift

enum LoadingState {
    case initial
    case loading
    case content
    case error(Error)
}

final class SearchViewModel {
    
    private lazy var searchService = GithubSearchService()
    private var currentSearchKey = ""
    private var lastFetchedPage = 1
    private let fetchedResultsPerRequest = 30
    
    var searchResultsViewModels = Variable<[SingleSearchResultViewModel]>([SingleSearchResultViewModel]())
    var canFetchMoreResults = false
    var loadingState = Variable<LoadingState>(.initial)
    
    func searchForResults(with key: String?) {
        currentSearchKey = key ?? ""
        lastFetchedPage = 1
        
        guard let textSearch = key,
            !textSearch.isEmpty else {
            clearSearchedUsersAndRepos()
            return
        }
        loadingState.value = .loading
        
        searchService.searchForUsersAndRepo(by: textSearch,
                                            page: lastFetchedPage) { [weak self] (searchedUsers, searchedRepos, error) in
            guard let strongSelf = self else {
                self?.loadingState.value = .content
                return
            }
            if let error = error {
                self?.loadingState.value = .error(error)
            } else {
                self?.loadingState.value = .content
                strongSelf.searchResultsViewModels.value = strongSelf.parseResultsToDisplay(from: searchedUsers, searchedRepos)
            }
        }
    }
    
    func fetchMoreResults() {
        guard !currentSearchKey.isEmpty else {
            canFetchMoreResults = false
            return
        }
        lastFetchedPage += 1
        
        searchService.searchForUsersAndRepo(by: currentSearchKey,
                                            page: lastFetchedPage) { [weak self] (searchedUsers, searchedRepos, error) in
            guard let strongSelf = self else {
                return
            }
            let resultsToDisplay = strongSelf.parseResultsToDisplay(from: searchedUsers, searchedRepos)
                                                
            strongSelf.searchResultsViewModels.value.append(contentsOf: resultsToDisplay)
            
            if let error = error {
                self?.loadingState.value = .error(error)
            }
        }
    }
    
    private func parseResultsToDisplay(from searchedUsers: SearchedUsers?,
                                       _ searchedRepos: SearchedRepos?) -> [SingleSearchResultViewModel] {
        var resultsToDisplay = [SingleSearchResultViewModel]()
        var userResults = [SingleSearchResultViewModel]()
        var reposResults = [SingleSearchResultViewModel]()
        
        if let users = searchedUsers?.users {
            userResults = SingleSearchResultViewModel.searchResultViewModels(from: users)
        }
        if let repos = searchedRepos?.repos {
            reposResults = SingleSearchResultViewModel.searchResultViewModels(from: repos)
        }
        
        // check if it's there more results to fetch
        if userResults.count < fetchedResultsPerRequest && reposResults.count < fetchedResultsPerRequest {
            canFetchMoreResults = false
        } else {
            canFetchMoreResults = true
        }
        resultsToDisplay = userResults + reposResults

        let resultsSortedById = resultsToDisplay.sorted { $0.id < $1.id }
        
        return resultsSortedById
    }
    
    private func clearSearchedUsersAndRepos() {
        canFetchMoreResults = false
        searchService.cancelCachedRequests()
        searchResultsViewModels.value.removeAll()
    }
}
