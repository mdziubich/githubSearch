//
//  UserDetailsView.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 23/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import AlamofireImage
import SnapKit
import UIKit

class UserDetailsView: UIView {
    
    private let avatarWidthHeight: CGFloat = 200
    private let avatarImage = UIImageView()
    private let usernameLabel = UILabel()
    private let numberOfStarsLabel = UILabel()
    private let numberOfFollowersabel = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        addSubviews()
        setupStyling()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with viewModel: UserDetailsViewModel) {
        usernameLabel.text = "username: " + viewModel.username
        
        guard let urlString = viewModel.avatarUrlString,
            let avatarUrl = URL(string: urlString) else {
            addErrorLabelToImage(message: "Avatar unavailable")
            return
        }
        
        avatarImage.af_setImage(withURL: avatarUrl,
                                progressQueue: DispatchQueue.main,
                                imageTransition: UIImageView.ImageTransition.crossDissolve(GlobalLayoutElements.animationDuration),
                                runImageTransitionIfCached: true) { [weak self] response in
                                    switch response.result {
                                    case .success:
                                        return
                                    case .failure(let error):
                                        self?.addErrorLabelToImage(message: error.localizedDescription)
                                    }
                                    
        }
    }
    
    private func addSubviews() {
        [avatarImage, usernameLabel, numberOfStarsLabel, numberOfFollowersabel].forEach {
            addSubview($0)
        }
    }
    
    private func setupStyling() {
        [usernameLabel, numberOfFollowersabel, numberOfStarsLabel].forEach {
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 17)
            $0.textColor = .black
        }
        
        numberOfFollowersabel.text = "Number of followers: "
        numberOfStarsLabel.text = "Number of stars: "
        avatarImage.backgroundColor = .green
        avatarImage.clipsToBounds = true
        avatarImage.contentMode = .scaleAspectFill
    }
    
    private func setupConstraints() {
        usernameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(GlobalLayoutElements.bigMargin)
        }
        
        numberOfStarsLabel.snp.makeConstraints { make in
            make.left.right.equalTo(usernameLabel)
            make.top.equalTo(usernameLabel.snp.bottom).offset(GlobalLayoutElements.bigMargin)
        }
        
        numberOfFollowersabel.snp.makeConstraints { make in
            make.left.right.equalTo(usernameLabel)
            make.top.equalTo(numberOfStarsLabel.snp.bottom).offset(GlobalLayoutElements.bigMargin)
        }
        
        avatarImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(usernameLabel.snp.top).offset(-GlobalLayoutElements.bigMargin)
            make.width.height.equalTo(avatarWidthHeight)
        }
    }
    
    private func addErrorLabelToImage(message: String) {
        let errorLabel = UILabel()
        
        addSubview(errorLabel)
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.font = UIFont.systemFont(ofSize: 17)
        errorLabel.textColor = .black
        errorLabel.text = message
        errorLabel.snp.makeConstraints { make in
            make.edges.equalTo(avatarImage)
        }
    }
}
