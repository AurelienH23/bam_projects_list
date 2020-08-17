//
//  ProjectCell.swift
//  bam_projects
//
//  Created by Aurélien Haie on 17/08/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

class ProjectCell: UICollectionViewCell {
    
    // MARK: Properties
    
    var project: Project? {
        didSet {
            guard let project = project else { return }
            titleLabel.text = project.name
            descriptionLabel.text = project.body ?? "no description for this project"
        }
    }
    
    // MARK: View elements
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "descriptionLabel"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.alpha = 0.5
        return view
    }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
    
    // MARK: Custom funcs
    
    fileprivate func setupViews() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(divider)
        
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: .mediumSpace, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: .mediumSpace, width: 0, height: 0)
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: .smallSpace, paddingLeft: .mediumSpace, paddingBottom: .mediumSpace, paddingRight: .mediumSpace, width: 0, height: 0)
        divider.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
    }
    
}

