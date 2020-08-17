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
        let projectsList = createTab(for: ProjectsListViewController(collectionViewLayout: UICollectionViewFlowLayout()), withTitle: "Projects", andImage: UIImage(systemName: "tray.full.fill"))
        let favList = createTab(for: FavViewController(collectionViewLayout: UICollectionViewFlowLayout()), withTitle: "Favorites", andImage: UIImage(systemName: "bookmark.fill"))
        
        viewControllers = [projectsList, favList]
    }
    
    fileprivate func createTab(for controller: UIViewController, withTitle: String, andImage: UIImage?) -> UIViewController {
        let currentTab = UINavigationController(rootViewController: controller)
        currentTab.tabBarItem = UITabBarItem(title: withTitle, image: andImage, tag: 0)
        return currentTab
    }
    
}
