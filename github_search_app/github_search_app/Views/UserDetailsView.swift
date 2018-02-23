//
//  UserDetailsView.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 23/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

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
        
        usernameLabel.text = "Gosia"
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
}
