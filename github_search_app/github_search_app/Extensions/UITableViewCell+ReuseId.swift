//
//  UITableViewCell+ReuseId.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 20/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static var reuseId: String {
        return className
    }
}
