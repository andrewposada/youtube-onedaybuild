//
//  Model.swift
//  youtube-onedaybuild
//
//  Created by Andrew Posada on 8/23/20.
//  Copyright © 2020 Andrew Posada. All rights reserved.
//

import Foundation

class Model {
    
    func getVideos() {
        
        // Create a URL object
        let url = URL(string: Constants.API_URL)
        
        guard url != nil else{
            return
        }
        
        // Get a URLSession object
        let session = URLSession.shared
        // Get a data task from the URLSession object
        let datatTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check if there were any errors
            if error != nil || data == nil {
                return
            }
            
            // Parsin the data into video objects
        }
        // Kikoff the task
        datatTask.resume()
        
    }
    
}
