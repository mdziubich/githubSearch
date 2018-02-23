//
//  SearchResultDisplayable.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 22/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import Foundation

enum ResultType {
    case user(avaratUrl: String?)
    case repo
    
    var hasDetailsToDisplay: Bool {
        switch self {
        case .user: return true
        case .repo: return false
        }
    }
    
    var avatarUrlString: String? {
        switch self {
        case .user(let avaratUrl):
            return avaratUrl
        case .repo:
            return nil
        }
    }
}

protocol SearchResultDisplayable {
    var id: Int { get }
    var name: String { get }
    var type: ResultType { get }
}
