//
//  FavViewController.swift
//  bam_projects
//
//  Created by Aurélien Haie on 17/08/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import CoreData
import UIKit

class FavViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: Properties
    
    let cellId = "cellId"
    let noCellId = "noCellId"
    
    var projects = [Project]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        NotificationCenter.default.addObserver(self, selector: #selector(fetchProjects), name: .projectFaved, object: nil)
        setupCollectionView()
        fetchProjects()
    }
    
    // MARK: Custom funcs
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        
        collectionView.register(ProjectCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(NoFavCell.self, forCellWithReuseIdentifier: noCellId)
    }
    
    @objc fileprivate func fetchProjects() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CDProject")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            
            if result.count > 0 {
                var favList = [Project]()
                for object in result as! [NSManagedObject] {
                    let id = object.value(forKey: "id") as! Int
                    let name = object.value(forKey: "name") as! String
                    let body = object.value(forKey: "body") as? String
                    let url = object.value(forKey: "url") as! String
                    
                    let favProject = Project(id: id, name: name, body: body, url: url)
                    favList.append(favProject)
                }
                self.projects = favList
            } else {
                
            }
        } catch {
            print("Failed checking project's existence")
        }
    }
    
    // MARK: Collection view
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projects.count == 0 ? 1 : projects.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if projects.count == 0 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: noCellId, for: indexPath) as! NoFavCell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProjectCell
            cell.project = projects[indexPath.item]
            cell.updateFavView(true)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 2 * .mediumSpace, height: projects.count == 0 ? 250 : 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .mediumSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: .mediumSpace, left: .mediumSpace, bottom: .mediumSpace, right: .mediumSpace)
    }
    
}
