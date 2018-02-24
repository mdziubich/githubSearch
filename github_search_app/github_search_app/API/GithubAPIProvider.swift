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
//        super.init(plugins: [])
        super.init(plugins: [NetworkLoggerPlugin(verbose: true)])
    }
    
    @discardableResult
    func request(target: T,
                 success successCallback: @escaping ([String: Any]?) -> Void,
                 error errorCallback: @escaping (Error?) -> Void) -> Cancellable {
        
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
                    errorCallback(error)
                } else {
                    successCallback(responseDict)
                }
            case .failure(let moyaError):
                self.handleError(moyaError, error: errorCallback)
            }
        }
    }
    
    private func handleError(_ moyaError: MoyaError, error errorCallback: @escaping (Error?) -> Void) {
        switch moyaError {
        case .underlying(let nsError as NSError, _):
            if nsError.code == NSURLErrorCancelled {
                // we don't want to report cancelled errors
                errorCallback(nil)
            } else {
                errorCallback(moyaError)
            }
        default:
            if let response = moyaError.response,
                response.statusCode == NSURLErrorCancelled {
                // we don't want to report cancelled errors
                errorCallback(nil)
            } else {
                errorCallback(moyaError)
            }
        }
    }
}
