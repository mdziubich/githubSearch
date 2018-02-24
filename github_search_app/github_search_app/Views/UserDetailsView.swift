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

class UserDetailsView: LoadableView {
    
    private let avatarWidthHeight: CGFloat = 200
    private let avatarImage = UIImageView()
    private let usernameLabel = UILabel()
    
    let numberOfStarsLabel = UILabel()
    let numberOfFollowersLabel = UILabel()
    
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
    
    override func addSubviews() {
        [avatarImage, usernameLabel, numberOfStarsLabel, numberOfFollowersLabel].forEach {
            addSubview($0)
        }
        super.addSubviews()
    }
    
    override func setupStyling() {
        super.setupStyling()
        backgroundColor = .gray
        
        [usernameLabel, numberOfFollowersLabel, numberOfStarsLabel].forEach {
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 17)
            $0.textColor = .black
        }
        
        avatarImage.backgroundColor = .white
        avatarImage.clipsToBounds = true
        avatarImage.contentMode = .scaleAspectFill
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        usernameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(GlobalLayoutElements.bigMargin)
        }
        
        numberOfStarsLabel.snp.makeConstraints { make in
            make.left.right.equalTo(usernameLabel)
            make.top.equalTo(usernameLabel.snp.bottom).offset(GlobalLayoutElements.bigMargin)
        }
        
        numberOfFollowersLabel.snp.makeConstraints { make in
            make.left.right.equalTo(usernameLabel)
            make.top.equalTo(numberOfStarsLabel.snp.bottom).offset(GlobalLayoutElements.bigMargin)
        }
        
        avatarImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(usernameLabel.snp.top).offset(-GlobalLayoutElements.bigMargin)
            make.width.height.equalTo(avatarWidthHeight)
        }
        
        loadingBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
