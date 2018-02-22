//
//  SearchResultDisplayable.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 22/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import Foundation

enum ResultType {
    case user
    case repo
    
    var hasDetailsToDisplay: Bool {
        return self == .user
    }
}

protocol SearchResultDisplayable {
    var id: Int { get }
    var name: String { get }
    var type: ResultType { get }
}
