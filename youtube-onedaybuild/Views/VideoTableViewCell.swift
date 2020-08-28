//
//  VideoTableViewCell.swift
//  youtube-onedaybuild
//
//  Created by Andrew Posada on 8/27/20.
//  Copyright © 2020 Andrew Posada. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var video:Video?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setCell(_ v:Video){
        self.video = v
        
        //Ensure thaat we have a video
        guard self.video != nil else{
            return
        }
        // Set the title
        self.titleLabel.text = video?.title
        
        // Set the date
        // use this website for formats: https://nsdateformatter.com
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        
        self.dateLabel.text = df.string(from: video!.published)
        
        // Set the Thumbnail
        guard self.video!.thumbnail != "" else{
            return
        }
        
        // check cache before downloading data
        if let cachedData = CacheManager.getVideoCache(self.video!.thumbnail) {
            
            // set the thumbnail imageView
            self.thumbnailImageView.image = UIImage(data: cachedData)
            return
            
        }
        
        //Download the thumbnail data
        let url = URL(string: self.video!.thumbnail)
        
        //  Get the shared url session object
        let session = URLSession.shared
        
        // Create a data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                // save the data into the cache
                CacheManager.setVideoCache(url!.absoluteString, data)
                
                // check that the downloaded url matches the video thumbnail url that this cell is currently set to display because cells get reused. A scenario can arise where the data is being downloaded and the cell gets recycled.
                if url!.absoluteString != self.video?.thumbnail {
                    // video cell has been recylced for anoter video and no longer matches the thumbnail that was downloaded
                    return
                }
                
                // create the image object
                let image = UIImage(data: data!)
                
                // set the image view
                //we use dispatch queue to make sure this gets processed on the main thread since view processes should be handled in the mainn thread and not the background for performance.
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
                
            }
            
        }
        // Start data task
        dataTask.resume()
    }

}
