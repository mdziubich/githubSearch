//
//  GithubUserDetailsService.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 23/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import Moya

final class GithubUserDetailsService {
    
    private lazy var apiProvider = GithubAPIProvider<GithubAPI>()
    
    func fetchStarredRepositories(for user: String, completion: @escaping (_ numberOfStars: Int?, _ error: Error?) -> Void) {
        apiProvider.request(target: .userStarredRepositories(username: user), success: { responseDict in
            guard let responseDict = responseDict else {
                completion(nil, nil)
                return
            }
            
        }, error: { error in
            completion(nil, error)
        })
    }
    
    func fetchFollowers(for user: String, completion: @escaping (_ numberOfStars: Int?, _ error: Error?) -> Void) {
        apiProvider.request(target: .userFollowers(username: user), success: { responseDict in
            guard let responseDict = responseDict else {
                completion(nil, nil)
                return
            }
            
        }, error: { error in
            completion(nil, error)
        })
    }
}
