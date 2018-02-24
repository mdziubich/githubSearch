//
//  SearchContentView.swift
//  github_search_app
//
//  Created by Małgorzata Dziubich on 20/02/2018.
//  Copyright © 2018 Małgorzata Dziubich. All rights reserved.
//

import SnapKit

final class SearchContentView: LoadableView {
    
    private let singleCellHeight: CGFloat = 50.0
    
    let resultsTableView = UITableView()
    let searchInputTextField = SearchTextField()
    
    init() {
        super.init(frame: CGRect.zero)
        addSubviews()
        setupStyling()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addSubviews() {
        addSubview(resultsTableView)
        addSubview(searchInputTextField)
        super.addSubviews()
    }
    
    override func setupStyling() {
        super.setupStyling()
        
        searchInputTextField.backgroundColor = .white
        searchInputTextField.placeholder = "Search for users and repos..."
        searchInputTextField.clearButtonMode = .whileEditing
        searchInputTextField.autocorrectionType = .no
        searchInputTextField.autocapitalizationType = .none
        
        resultsTableView.rowHeight = singleCellHeight
        resultsTableView.backgroundColor = .green
        resultsTableView.separatorStyle = .none
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        searchInputTextField.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(singleCellHeight)
        }
        
        resultsTableView.snp.makeConstraints { make in
            make.top.equalTo(searchInputTextField.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        loadingBackgroundView.snp.makeConstraints { make in
            make.edges.equalTo(resultsTableView)
        }
    }
}
