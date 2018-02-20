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
    case searchUser(key: String)
    case searchRepo(key: String)
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .searchUser: return ""
        case .searchRepo: return ""
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        //TODO: change it if there will be some parameters
        return .requestPlain
    }
    
    var headers: [String: String]? {
        return ["Accept": "application/vnd.github.v3+json",
                "User-Agent": "mdziubich"]
    }
}
