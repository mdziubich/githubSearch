//
//  UserDetailsViewModel.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 23/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import Foundation

class UserDetailsViewModel {
    
    private let userName: String
    
    init(from viewModel: SingleSearchResultViewModel) {
        userName = viewModel.title
    }
}
