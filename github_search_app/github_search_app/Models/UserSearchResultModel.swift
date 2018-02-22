//
//  UserSearchResultModel.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 22/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import Foundation
import ObjectMapper

final class SearchedUsers: ImmutableMappable {
    
    var users: [UserSearchResult]?
    
    init(map: Map) throws {
        users = try? map.value("items")
    }
}

final class UserSearchResult: ImmutableMappable, SearchResultDisplayable {
    
    let id: Int
    let name: String
    let avatarUrl: String?
    let followersUrl: String?
    let starredUrl: String?
    let type: ResultType = .user
    
    init(map: Map) throws {
        id              = try map.value("id")
        name            = try map.value("login")
        avatarUrl       = try? map.value("avatar_url")
        followersUrl    = try? map.value("followers_url")
        starredUrl      = try? map.value("starred_url")
    }
}
