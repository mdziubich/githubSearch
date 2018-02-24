//
//  LoadableView.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 24/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import UIKit

class LoadableView: UIView {
    
    let loadingBackgroundView = UIView()
    private let activityIndicator = UIActivityIndicatorView()
    
    func showLoadingIndicator() {
        loadingBackgroundView.alpha = 1
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        loadingBackgroundView.alpha = 0
        activityIndicator.stopAnimating()
    }
    
    func addSubviews() {
        addSubview(loadingBackgroundView)
        loadingBackgroundView.addSubview(activityIndicator)
    }
    
    func setupStyling() {
        loadingBackgroundView.alpha = 0
        loadingBackgroundView.backgroundColor = UIColor.purple.withAlphaComponent(0.7)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
    }
    
    func setupConstraints() {
        activityIndicator.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
