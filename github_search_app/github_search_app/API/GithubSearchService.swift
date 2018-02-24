
//
//  GithubSearchService.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 20/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import Moya

final class GithubSearchService: CancellableCachedRequestsHandling {
    
    private lazy var apiProvider = GithubAPIProvider<GithubAPI>()
    
    var cachedRequests = [String: Cancellable]()
    
    //For unauthenticated requests, the rate limit allows you to make up to 10 requests per minute.
    
    /*
     https://developer.github.com/changes/2014-04-07-understanding-search-results-and-potential-timeouts/
     Some queries are computationally expensive for our search infrastructure to execute.
     To keep the Search API fast for everyone, we limit how long any individual query can run.
     In rare situations when a query exceeds the time limit,
     the API returns all matches that were found prior to the timeout.
    */
    func searchForUsersAndRepo(by key: String, page: Int, completion: @escaping (SearchedUsers?, SearchedRepos?, MoyaError?) -> Void) {
        //first cancell previous made requests
        cancelCachedRequests()
        
        let usersSearchRequest = apiProvider.request(target: .searchUser(key: key, page: page), success: { [searchedKey = key] responseDict in
            guard let responseDict = responseDict else {
                completion(nil, nil, nil)
                return
            }
            
            /*
             first check if request wasn't already cancelled and if it was cancelled the do not make any further
             requests and give nil in completion because next request was already made for the next searchKey
            */
            if self.cachedRequests["users:\(searchedKey)"] != nil {
                //it wasn't cancelled
                let users = try? SearchedUsers(JSON: responseDict)
                
                self.searchForRepos(by: key, page: page, foundUsers: users, completion: completion)
            } else {
                completion(nil, nil, nil)
            }
            
        }, error: { error in
            completion(nil, nil, error)
        })
        
        cachedRequests["users:\(key)"] = usersSearchRequest
    }
    
    private func searchForRepos(by key: String,
                                page: Int,
                                foundUsers: SearchedUsers?,
                                completion: @escaping (SearchedUsers?, SearchedRepos?, MoyaError?) -> Void) {
        let repoSearchRequest = apiProvider.request(target: .searchRepo(key: key, page: page), success: { [searchedKey = key] responseDict in
            guard let responseDict = responseDict else {
                completion(foundUsers, nil, nil)
                return
            }
            
            /*
             first check if request wasn't already cancelled and if it was cancelled the do not make any further
             requests and give nil in completion because next request was already made for the next searchKey
             */
            if self.cachedRequests["repos:\(searchedKey)"] != nil {
                //it wasn't cancelled
                let repos = try? SearchedRepos(JSON: responseDict)
                
                completion(foundUsers, repos, nil)
            } else {
                completion(nil, nil, nil)
            }
        }, error: { error in
            completion(nil, nil, error)
        })
        
        cachedRequests["repos:\(key)"] = repoSearchRequest
    }
}
