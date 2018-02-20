//
//  UITableViewCell+ReuseId.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 20/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import Foundation

extension UITableViewCell {
    
    static var resuseId: String {
        return className
    }
}
