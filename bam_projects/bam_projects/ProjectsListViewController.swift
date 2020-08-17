//
//  ProjectsListViewController.swift
//  bam_projects
//
//  Created by Aurélien Haie on 17/08/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

class ProjectsListViewController: UICollectionViewController {
    
    // MARK: Properties
    
    let cellId = "cellId"
    var projects = [String]() {
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
        collectionView.backgroundColor = .red
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
                    var projectsList = [String]()
                    json.forEach { (project) in
                        if let names = project["name"] as? String {
                            projectsList.append(names)
                        }
                    }
                    self.projects = projectsList
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
        return cell
    }
    
}

class ProjectCell: UICollectionViewCell {
    
    // MARK: View elements
    
    
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
