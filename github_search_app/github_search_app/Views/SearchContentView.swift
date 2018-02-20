//
//  SearchContentView.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 20/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import SnapKit

final class SearchContentView: UIView {
    
    private let singleCellHeight: CGFloat = 50.0
    
    let resultsTableView = UITableView()
    
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
        addSubview(resultsTableView)
    }
    
    private func setupStyling() {
        resultsTableView.rowHeight = singleCellHeight
        resultsTableView.backgroundColor = .green
    }
    
    private func setupConstraints() {
        resultsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
