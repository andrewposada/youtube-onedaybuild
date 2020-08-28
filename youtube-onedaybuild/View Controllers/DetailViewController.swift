//
//  DetialViewController.swift
//  youtube-onedaybuild
//
//  Created by Andrew Posada on 8/28/20.
//  Copyright © 2020 Andrew Posada. All rights reserved.
//

import UIKit
import WebKit // this can be manually added in in the project manager file

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var textView: UITextView!
    
    var video:Video?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // clear the fields
        titleLable.text = ""
        dateLabel.text = ""
        textView.text = ""
        
        // Check if there is a video
        guard video != nil else {
            return
        }
        
        // create embedded URL
        let embedURLString = Constants.YT_EMBED_URL + video!.videoId
        
        // load it into the webview
        let url =  URL(string: embedURLString)
        let request = URLRequest(url: url!)
        webView.load(request)
        
        // set the title
        titleLable.text = video!.title
        
        // set the date
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        dateLabel.text = df.string(from: video!.published)
        
        // set the description
        textView.text = video!.description
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
