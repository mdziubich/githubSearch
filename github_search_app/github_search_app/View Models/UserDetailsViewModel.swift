//
//  UserDetailsViewModel.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 23/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import RxSwift

final class UserDetailsViewModel {
    
    private let detailsService = GithubUserDetailsService()
    
    let username: String
    let avatarUrlString: String?
    var numberOfStars = PublishSubject<String>()
    var numberOfFollowers = PublishSubject<String>()
    var loadingState = PublishSubject<LoadingState>()
    
    init(from viewModel: SingleSearchResultViewModel) {
        username = viewModel.title
        avatarUrlString = viewModel.avatarUrlString
    }
    
    func fetchStarredReposAndFollowers() {
        loadingState.onNext(.loading)
        
        detailsService.fetchStarredReposAndFollowers(for: username) { [weak self] (numberOfStars, numberOfFollowers, error) in
            if let error = error {
                self?.loadingState.onNext(.error(error))
            } else {
                self?.loadingState.onNext(.content)
            }
            
            if let numberOfStars = numberOfStars {
                self?.numberOfStars.onNext("Number of stars: \(numberOfStars)")
            }
            if let numberOfFollowers = numberOfFollowers {
                self?.numberOfFollowers.onNext("Number of followers: \(numberOfFollowers)")
            }
        }
    }
}
