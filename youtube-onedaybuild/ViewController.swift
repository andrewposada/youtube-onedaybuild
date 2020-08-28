//
//  ViewController.swift
//  youtube-onedaybuild
//
//  Created by Andrew Posada on 8/23/20.
//  Copyright © 2020 Andrew Posada. All rights reserved.
//

import UIKit
// UITableViewDataSource is a protocol used to display information in the tableView
// UITableViewDelegate is a protocal used to handle user interactions with the table view

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ModelDelegate {
    
   
    

    
    @IBOutlet weak var tableView: UITableView!
    
    
    var model = Model()
    var videos = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set this viewcontroller as the datasource and the delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        // Set itself as the delegate of the model
        model.delegate = self
        
        model.getVideos()
    }
    
        // MARK: - Model Delegate Methods
    
    func videosFetched(_ videos: [Video]) {
        
        // Set the returned videos to our video property
        self.videos = videos
        
        // Refresh the tableview (this will re-call all thee TableView methods that conform to the UITableViewDataSource protocol
        tableView.reloadData()
    }
    
    // MARK: - TableView Methods for displaying required to conform to the UITableViewDataSource protocol
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return videos.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VIDEOCELL_ID, for: indexPath)
    
        // Configure the cell with the data
        // Get the title for the video in question
        let title = self.videos[indexPath.row].title
        
        cell.textLabel?.text = title
    
        // Return the cell
        return cell
    }
    
    // MARK: - TableView Methods for handling user interactions that conform to the UITableViewDelegate protocol (these are not required)
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}

