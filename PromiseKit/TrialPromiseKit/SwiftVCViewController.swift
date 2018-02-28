//
//  SwiftVCViewController.swift
//  TrialPromiseKit
//
//  Created by weeclicks on 07/12/2017.
//  Copyright © 2017 weeclicks. All rights reserved.
//

import UIKit
import PromiseKit

class SwiftVCViewController: UIViewController {

    @IBOutlet weak var ivImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func downloadSongMetdata(artist: String, title: String) -> Promise<Any> {
        return Promise { fulfil, reject in
            //asdsd
            
        }
    }
    
    func downloadAlbumArt(url: String) -> Promise<UIImage> {
        return Promise { fulfil, reject in
            // Create http request
            if (url == "www.google.com") {
                fulfil(UIImage.init(named: "car")!)
            }
            else {
                reject(NSError.init(domain: "www.weeclicks.com", code: 99, userInfo: nil))
            }
            
        }
    }
    
    @IBAction func displayAction(_ sender: Any) {
        downloadAlbumArt(url: "www.google.coma")
            .then() {
                image in
                self.ivImage.image = image;
        }
            .catch() {
                err in
                self.ivImage.image = nil;
                self.ivImage.backgroundColor = UIColor.red;
        }
        /*
        downloadSongMetdata(artist: "Artist", title: "title")
            .then() {
                json in
//                let albumArtUrl = json.getURL(key: "album Art")
//                print("\(json)")
//                return downloadAlbumArt(url: theUrl);
        }
            .then() {
                image in
                self.ivImage.image = image
                
        }
            .catch() {
                err in
                self.ivImage.image = nil;
                self.ivImage.backgroundColor = UIColor.red;
        }
         */
    }

}

