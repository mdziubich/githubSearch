//
//  MoyaError+Cancelled.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 24/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import Moya

extension MoyaError {
    
    var isCancelled: Bool {
        switch self {
        case .underlying(let nsError as NSError, _):
            return nsError.code == NSURLErrorCancelled
        default:
            if let response = self.response,
                response.statusCode == NSURLErrorCancelled {
                return true
            } else {
                return false
            }
        }
    }
}
