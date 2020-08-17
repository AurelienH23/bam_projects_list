//
//  ProjectsListViewController.swift
//  bam_projects
//
//  Created by Aurélien Haie on 17/08/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

class ProjectsListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: Properties
    
    let cellId = "cellId"
    var projects = [Project]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchProjects()
    }
    
    // MARK: Custom funcs
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(ProjectCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    fileprivate func fetchProjects() {
        
        guard let url = URL(string: "https://api.github.com/orgs/bamlab/repos?page=1") else { return }
        // TODO: err case
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch projects with err:", err)
                // TODO: err case
                return
            }
            
            do {
                guard let data = data else { return }
                // TODO: err case
                
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    var projectsList = [Project]()
                    json.forEach { (project) in
                        let id = project["id"] as! Int
                        let name = project["name"] as! String
                        let body = project["description"] as? String
                        let htmlUrl = project["html_url"] as! String
                        var currentProject = Project(id: id, name: name, body: body, url: htmlUrl)
                        projectsList.append(currentProject)
                    }
                    
                    DispatchQueue.main.async {
                        self.projects = projectsList
                    }
                }
            } catch let error as NSError {
                // TODO: err case
                print("Failed to load: \(error.localizedDescription)")
            }
            
        }.resume()
    }
    
    // MARK: Collection view
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projects.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProjectCell
        cell.project = projects[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
