//
//  ProjectsListViewController.swift
//  bam_projects
//
//  Created by Aurélien Haie on 17/08/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import CoreData
import UIKit

class ProjectsListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: Properties
    
    let cellId = "cellId"
    let errorCellId = "errorCellId"
    var isErrorLoading = false
    var projects = [Project]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Projects"
        setupCollectionView()
        fetchProjects()
    }
    
    // MARK: Custom funcs
    
    fileprivate func setupCollectionView() {
        let reloader = UIRefreshControl(frame: .zero)
        reloader.addTarget(self, action: #selector(fetchProjects), for: .valueChanged)
        collectionView.refreshControl = reloader
        
        collectionView.backgroundColor = .white
        
        collectionView.register(ProjectCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(ErrorCell.self, forCellWithReuseIdentifier: errorCellId)
    }
    
    @objc fileprivate func fetchProjects() {
        
        guard let url = URL(string: "https://api.github.com/orgs/bamlab/repos?page=1") else {
            self.handleError()
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch projects with err:", err)
                self.handleError()
                return
            }
            
            do {
                guard let data = data else {
                    self.handleError()
                    return
                }
                
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    var projectsList = [Project]()
                    json.forEach { (project) in
                        let id = project["id"] as! Int
                        let name = project["name"] as! String
                        let body = project["description"] as? String
                        let htmlUrl = project["html_url"] as! String
                        let currentProject = Project(id: id, name: name, body: body, url: htmlUrl)
                        projectsList.append(currentProject)
                    }
                    
                    DispatchQueue.main.async {
                        self.projects = projectsList
                        self.collectionView.refreshControl?.endRefreshing()
                    }
                }
            } catch let error as NSError {
                self.handleError()
                print("Failed to load: \(error.localizedDescription)")
            }
            
        }.resume()
    }
    
    fileprivate func handleError() {
        isErrorLoading = true
        collectionView.reloadData()
        collectionView.refreshControl?.endRefreshing()
    }
    
    // MARK: Collection view
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isErrorLoading ? 1 : projects.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isErrorLoading {
            return collectionView.dequeueReusableCell(withReuseIdentifier: errorCellId, for: indexPath) as! ErrorCell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProjectCell
            cell.project = projects[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 2 * .mediumSpace, height: isErrorLoading ? 250 : 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .mediumSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: .mediumSpace, left: .mediumSpace, bottom: .mediumSpace, right: .mediumSpace)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProject = projects[indexPath.item]
        
        // check if already faved
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CDProject")
        
        // the predicate doesn't work here..
//        let predicateID = NSPredicate(format: "id == %d", selectedProject.id)
//        request.predicate = predicateID
        
        do {
            let result = try context.fetch(request)
            
            if result.count > 0 {
                var isDeleted = false
                for object in result as! [NSManagedObject] {
                    if let persistedObjectId = object.value(forKey: "id") as? Int, persistedObjectId == selectedProject.id {
                        context.delete(object)
                        NotificationCenter.default.post(name: .projectFaved, object: nil)
                        isDeleted = true
                        let selectedCell = collectionView.cellForItem(at: indexPath) as! ProjectCell
                        selectedCell.updateFavView(false)
                    }
                }
                
                if !isDeleted {
                    addNewFavProject(fromIndexPath: indexPath)
                }
            } else {
                addNewFavProject(fromIndexPath: indexPath)
            }
        } catch {
            print("Failed checking project's existence")
        }
    }
    
    func addNewFavProject(fromIndexPath indexPath: IndexPath) {
        let selectedProject = projects[indexPath.item]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CDProject", in: context)
        let newProject = NSManagedObject(entity: entity!, insertInto: context)

        newProject.setValue(selectedProject.id, forKey: "id")
        newProject.setValue(selectedProject.name, forKey: "name")
        newProject.setValue(selectedProject.body, forKey: "body")
        newProject.setValue(selectedProject.url, forKey: "url")

        do {
            try context.save()
            NotificationCenter.default.post(name: .projectFaved, object: nil)
            let selectedCell = collectionView.cellForItem(at: indexPath) as! ProjectCell
            selectedCell.updateFavView(true)
        } catch {
            print("Failed saving a project locally")
        }
    }
    
}
