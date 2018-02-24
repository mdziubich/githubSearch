//
//  UserDetailsViewController.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 23/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class UserDetailsViewController: UIViewController {

    private lazy var contentView = UserDetailsView()
    private let viewModel: UserDetailsViewModel
    private let disposeBag = DisposeBag()
    
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
        setupObservables()
        contentView.setup(with: viewModel)
        viewModel.fetchStarredReposAndFollowers()
    }
    
    @objc func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupBackButton() {
        let backButton = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(UserDetailsViewController.goBack))
        navigationItem.rightBarButtonItem = backButton
    }
    
    private func setupObservables() {
        viewModel.numberOfStars
            .bind(to: contentView.numberOfStarsLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.numberOfFollowers
            .bind(to: contentView.numberOfFollowersLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.loadingState
            .subscribe(onNext: handleLoading)
            .disposed(by: disposeBag)
    }
    
    private func handleLoading(state: LoadingState) {
        switch state {
        case .loading:
            contentView.showLoadingIndicator()
        case .content:
            contentView.hideLoadingIndicator()
        case .error(let error):
            contentView.hideLoadingIndicator()
            handleError(error)
        }
        
    }
    
    private func handleError(_ error: Error) {
        print(error.localizedDescription)
    }
}
