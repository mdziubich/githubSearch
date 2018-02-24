//
//  BaseViewController.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 24/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    func handleError(_ error: Error, presentCompletion: (() -> Void)?, actionHandler: (() -> Void)?) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { _ in
            if let actionHandler = actionHandler {
                actionHandler()
            }
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: presentCompletion)
    }
}
