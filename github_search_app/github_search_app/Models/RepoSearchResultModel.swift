//
//  RepoSearchResultModel.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 22/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import Foundation
import ObjectMapper

final class SearchedRepos: ImmutableMappable {
    
    var repos: [RepoSearchResultModel]?
    
    init(map: Map) throws {
        repos = try? map.value("items")
    }
}

final class RepoSearchResultModel: ImmutableMappable, SearchResultDisplayable {
 
    let id: Int
    let name: String
    let type: ResultType = .repo
    
    init(map: Map) throws {
        id = try map.value("id")
        name = try map.value("full_name")
    }
}
