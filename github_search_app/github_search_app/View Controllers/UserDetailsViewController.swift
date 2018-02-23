//
//  UserDetailsViewController.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 23/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {

    private lazy var contentView = UserDetailsView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupBackButton()
    }
    
    @objc func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupBackButton() {
        let backButton = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(UserDetailsViewController.goBack))
        navigationItem.rightBarButtonItem = backButton
    }
}
