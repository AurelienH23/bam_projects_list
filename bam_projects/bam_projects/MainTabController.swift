//
//  MainTabController.swift
//  bam_projects
//
//  Created by Aurélien Haie on 17/08/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    // MARK: Custom funcs
    
    fileprivate func setupTabs() {
        let projectsList = ProjectsListViewController(collectionViewLayout: UICollectionViewFlowLayout())
        projectsList.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        let favList = FavViewController(collectionViewLayout: UICollectionViewFlowLayout())
        favList.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        viewControllers = [projectsList, favList]
    }
    
}
