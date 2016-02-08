//
//  DetailViewController.swift
//  Movie App
//
//  Created by Matt on 2/8/16.
//  Copyright © 2016 Matt Del Signore. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var info: UIView!
    
    var movie: NSDictionary!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the scrollview content size
        scroll.contentSize = CGSize(width: scroll.frame.size.width, height: info.frame.origin.y + info.frame.height)
        
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        
        titleLabel.text = title
        overviewLabel.text = overview
        
        overviewLabel.sizeToFit()
        
        let baseUrl = "http://image.tmdb.org/t/p/w500/"
        if let posterPath = movie["poster_path"] as? String{
            let imgUrl = NSURL(string: baseUrl + posterPath)
            posterImage.setImageWithURL(imgUrl!)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
