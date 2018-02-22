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
    
    func request(target: T,
                 success successCallback: @escaping ([String: Any]?) -> Void,
                 error errorCallback: @escaping (Error) -> Void) {
        
        request(target) { (result) in
            switch result {
            case .success(let response):
                guard let responseDict = try? response.mapJSON() as? [String: Any] else {
                    successCallback(nil)
                    return
                }
                successCallback(responseDict)
            case .failure(let moyaError):
                errorCallback(moyaError)
            }
        }
    }
}
