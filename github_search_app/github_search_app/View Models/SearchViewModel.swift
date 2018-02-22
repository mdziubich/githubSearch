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
    
    func searchForResults(with key: String?) {
        guard let textSearch = key else {
            clearSearchedUsersAndRepos()
            return
        }
        
        searchService.searchForUsersAndRepo(by: textSearch) { (users, repos, error) in
            
        }
    }
    
    private func clearSearchedUsersAndRepos() {
        searchResultsViewModels.value.removeAll()
    }
}
