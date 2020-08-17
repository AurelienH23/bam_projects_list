//
//  ErrorCell.swift
//  bam_projects
//
//  Created by Aurélien Haie on 17/08/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

class ErrorCell: UICollectionViewCell {
    
    // MARK: View elements
    
    let errorTitle: UILabel = {
        let label = UILabel()
        label.text = "Erreur lors du chargement des projets"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let errorDescription: UILabel = {
        let label = UILabel()
        label.text = "Veuillez vérifier votre connexion à internet, puis réessayez de charger les projets."
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
        addSubview(errorTitle)
        addSubview(errorDescription)
        
        errorTitle.anchor(top: nil, left: leftAnchor, bottom: centerYAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: .extraLargeSpace, paddingBottom: 0, paddingRight: .extraLargeSpace, width: 0, height: 0)
        errorDescription.anchor(top: errorTitle.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: .mediumSpace, paddingLeft: .extraLargeSpace, paddingBottom: 0, paddingRight: .extraLargeSpace, width: 0, height: 0)
    }
    
}
