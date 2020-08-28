//
//  Model.swift
//  youtube-onedaybuild
//
//  Created by Andrew Posada on 8/23/20.
//  Copyright © 2020 Andrew Posada. All rights reserved.
//

import Foundation

protocol ModelDelegate {
    func videosFetched(_ videos:[Video])
}

class Model {
    
    // this is an optional because initially, nothing has set itself as a delegat
    var delegate:ModelDelegate?
    
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
            do {
                // Parsing the data into video objects
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let response = try decoder.decode(Response.self, from: data!)
                
                if response.items != nil{
                    
                    DispatchQueue.main.async {
                        // Call the "videosFetched" method of the delegate
                        // items can be safely unwrapped because aa nil check was conducted
                        self.delegate?.videosFetched(response.items!)
                    }
                    
                }
                
                dump(response)
            }
            catch{
                
            }
            
            
            
        }
        // Kikoff the task
        datatTask.resume()
        
    }
    
}
