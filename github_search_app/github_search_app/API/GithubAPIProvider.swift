//
//  GithubAPIProvider.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 20/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import Moya

final class GithubAPIProvider<T: TargetType>: MoyaProvider<T> {
    
    init() {
        super.init(plugins: [])
//        super.init(plugins: [NetworkLoggerPlugin(verbose: true)])
    }
    
    @discardableResult
    func request(target: T,
                 success successCallback: @escaping ([String: Any]?) -> Void,
                 error errorCallback: @escaping (MoyaError?) -> Void) -> Cancellable {
        
        return request(target) { (result) in
            switch result {
            case .success(let response):
                let json = try? response.mapJSON()
                var jsonDict = json as? [String: Any]
                
                // added for parsing arrays not in dictionary
                if jsonDict == nil,
                    let jsonArray = json as? [[String: Any]] {
                    jsonDict = [GithubAPIConsts.resultsKey: jsonArray]
                }
                let responseDict = jsonDict ?? [:]
                
                if let errorMessage = responseDict["message"] as? String {
                    let error = NSError(domain: errorMessage, code: 0, userInfo: nil)
                    let moyaError = MoyaError.underlying(error, nil)
                    
                    errorCallback(moyaError)
                } else {
                    successCallback(responseDict)
                }
            case .failure(let moyaError):
                errorCallback(moyaError)
            }
        }
    }
}
