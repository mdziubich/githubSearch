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
    private let viewModel: UserDetailsViewModel
    
    init(viewModel: UserDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupBackButton()
        contentView.setup(with: viewModel)
    }
    
    @objc func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupBackButton() {
        let backButton = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(UserDetailsViewController.goBack))
        navigationItem.rightBarButtonItem = backButton
    }
}
