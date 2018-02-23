//
//  GithubAPI.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 20/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import Foundation
import Moya

enum GithubAPI: TargetType {
    case searchUser(key: String, page: Int)
    case searchRepo(key: String, page: Int)
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .searchUser: return "search/users"
        case .searchRepo: return "search/repositories"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .searchUser(let searchedTerm, let page),
             .searchRepo(let searchedTerm, let page):
            return ["q": searchedTerm,
                    "order": "asc",
                    "page": page]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var task: Task {
        guard let parametres = parameters else {
            return .requestPlain
        }
        return .requestParameters(parameters: parametres, encoding: parameterEncoding)
    }
    
    var headers: [String: String]? {
        return ["Accept": "application/vnd.github.v3+json",
                "User-Agent": "mdziubich"]
    }
}
