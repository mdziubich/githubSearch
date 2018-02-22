//
//  SearchViewModel.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 20/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

final class SearchViewModel {
    
    private lazy var searchService = GithubSearchService()
    
    var searchResultsViewModels = [SingleSearchResultViewModel]()
    
    func searchForResults(with key: String) {
        searchService.searchForUsersAndRepo(by: key) { (users, repos, error) in
            
        }
    }
}
