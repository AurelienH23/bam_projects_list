//
//  FavViewController.swift
//  bam_projects
//
//  Created by Aurélien Haie on 17/08/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

class FavViewController: UICollectionViewController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        collectionView.backgroundColor = .green
    }
    
}
