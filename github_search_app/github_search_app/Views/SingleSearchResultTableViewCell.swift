//
//  SingleSearchResultTableViewCell.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 20/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import UIKit

final class SingleSearchResultTableViewCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let margin: CGFloat = 15.0
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with viewModel: SingleSearchResultViewModel) {
        titleLabel.text = viewModel.title
        selectionStyle = viewModel.isSelectable ? .gray : .none
        accessoryType = viewModel.isSelectable ? .disclosureIndicator : .none
    }
    
    private func initialSetup() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(margin)
            make.top.bottom.equalToSuperview()
        }
        
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = false
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textColor = .black
        
        backgroundColor = .yellow
    }
}
