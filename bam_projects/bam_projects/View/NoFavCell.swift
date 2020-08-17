//
//  NoFavCell.swift
//  bam_projects
//
//  Created by Aurélien Haie on 17/08/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

class NoFavCell: UICollectionViewCell {
    
    // MARK: View elements
    
    let noFavTitle: UILabel = {
        let label = UILabel()
        label.text = "Aucun projet enregistré"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let noFavDescription: UILabel = {
        let label = UILabel()
        label.text = "Enregistrez des projets en cliquant dessus, vous les retrouverez ici."
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Custom funcs
    
    fileprivate func setupViews() {
        addSubview(noFavTitle)
        addSubview(noFavDescription)
        
        noFavTitle.anchor(top: nil, left: leftAnchor, bottom: centerYAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: .extraLargeSpace, paddingBottom: 0, paddingRight: .extraLargeSpace, width: 0, height: 0)
        noFavDescription.anchor(top: noFavTitle.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: .mediumSpace, paddingLeft: .extraLargeSpace, paddingBottom: 0, paddingRight: .extraLargeSpace, width: 0, height: 0)
    }
    
}
