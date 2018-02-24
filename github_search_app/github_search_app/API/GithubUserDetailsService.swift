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
    
    func fetchStarredReposAndFollowers(for user: String,
                                       completion: @escaping (_ numberOfStars: Int?, _ numberOfFollowers: Int?, _ error: Error?) -> Void) {
        let group = DispatchGroup()
        var responseError: Error?
        var numberOfStars: Int?
        var numberOfFollowers: Int?
        
        group.enter()
        apiProvider.request(target: .userStarredRepositories(username: user), success: { responseDict in
            numberOfStars = self.getNumberOfResults(for: responseDict)
            group.leave()
        }, error: { error in
            responseError = error
            group.leave()
        })
        
        group.enter()
        apiProvider.request(target: .userFollowers(username: user), success: { responseDict in
            numberOfFollowers = self.getNumberOfResults(for: responseDict)
            group.leave()
        }, error: { error in
            responseError = error
            group.leave()
        })
        
        group.notify(queue: .main) {
            completion(numberOfStars, numberOfFollowers, responseError)
            print("both done")
        }
    }
    
    private func getNumberOfResults(for responseDict: [String: Any]?) -> Int? {
        guard let responseDict = responseDict,
            let resultsArray = responseDict[GithubAPIConsts.resultsKey] as? [[String: Any]] else {
            return nil
        }
        return resultsArray.count
    }
}
