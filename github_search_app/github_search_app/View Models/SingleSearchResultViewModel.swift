//
//  SingleSearchResultViewModel.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 20/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import Foundation

final class SingleSearchResultViewModel {
    
    let id: Int
    let title: String
    
    init(from model: SearchResultDisplayable) {
        id = model.id
        title = model.name
    }
    
    static func searchResultViewModels(from models: [SearchResultDisplayable]) -> [SingleSearchResultViewModel] {
        var results = [SingleSearchResultViewModel]()
        
        models.forEach {
            let result = SingleSearchResultViewModel(from: $0)
            
            results.append(result)
        }
        return results
    }
}
