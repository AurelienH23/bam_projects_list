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
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "descriptionLabel"
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let favView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        return view
    }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        updateFavView(false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descriptionLabel.text = nil
        updateFavView(false)
    }
    
    // MARK: Custom funcs
    
    fileprivate func setupViews() {
        backgroundColor = UIColor(white: 0, alpha: 0.1)
        layer.cornerRadius = 16
        
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(favView)
        
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: .mediumSpace, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: .mediumSpace, width: 0, height: 0)
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: .smallSpace, paddingLeft: .mediumSpace, paddingBottom: .mediumSpace, paddingRight: .mediumSpace, width: 0, height: 0)
        favView.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: .mediumSpace, paddingLeft: 0, paddingBottom: 0, paddingRight: .mediumSpace, width: .smallSpace, height: .smallSpace)
    }
    
    func updateFavView(_ isFav: Bool) {
        favView.layer.borderColor = isFav ? UIColor.blue.cgColor : UIColor.lightGray.cgColor
        favView.backgroundColor = isFav ? .blue : .clear
    }
    
}

