//
//  UserDetailsViewModel.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 23/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import Foundation

class UserDetailsViewModel {
    
    let username: String
    let avatarUrlString: String?
    
    init(from viewModel: SingleSearchResultViewModel) {
        username = viewModel.title
        avatarUrlString = viewModel.avatarUrlString
    }
}
