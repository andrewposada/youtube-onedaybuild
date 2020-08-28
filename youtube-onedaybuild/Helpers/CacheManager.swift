//
//  CacheManager.swift
//  youtube-onedaybuild
//
//  Created by Andrew Posada on 8/28/20.
//  Copyright © 2020 Andrew Posada. All rights reserved.
//
// NOTE: this class is created to cache the videos in the tableView. When the video information is displayed, it is downloaded. Everytime the cell in the tableView is off screen and dequeued and then brought back into screen, it will redownload the information. To avoid this redownload, a cache manager can be used to store that information and reuse it without needing to redownload it.
import Foundation

class CacheManager {
    
    static var cache = [String:Data]()
    
    // this function is a static function so that an instance of the CacheManager does not need to be created to use the method
    static func setVideoCache(_ url:String, _ data:Data?) {
        
        // Store the image data and use the url as the key
        cache[url] = data
        
    }
    
    //return type needs to be optional because the url can return nil
    static func getVideoCache(_ url:String) -> Data? {
        
        // if the url exists, this function will return the value in the cache dictionary for the specified url. If it does not exist, since the return type is optional, it will return nil
        
        // try to get the data for the specified url
        return cache[url]
        
    }
    
}
