//
//  GithubSearchService.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 20/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import Foundation

final class GithubSearchService {
    
    lazy var apiProvider = GithubAPIProvider<GithubAPI>()
    
    func searchForUsersAndRepo(with key: String) {
        apiProvider.request(target: .searchUser(key: key), success: { result in
            print(result)
        }, error: { error in
            print(error)
        })
    }
}
