//
//  CancellableCachedRequestsHandling.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 22/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import Moya

protocol CancellableCachedRequestsHandling: class {
    var cachedRequests: [String: Cancellable] { get set }
    
    func cancelCachedRequests()
}

extension CancellableCachedRequestsHandling {
    
    func cancelCachedRequests() {
        guard !cachedRequests.isEmpty else {
            return
        }
        cachedRequests.forEach {
            if !$0.value.isCancelled {
                $0.value.cancel()
            }
        }
        cachedRequests.removeAll()
    }
}
