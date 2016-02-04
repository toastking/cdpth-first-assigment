//
//  MoviesViewController.swift
//  Movie App
//
//  Created by Matt on 1/29/16.
//  Copyright © 2016 Matt Del Signore. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    
    //movies Json data
    var movies: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load the tbaleview stuff
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        //load the data
        loadFromNetwork(nil)
        
        //add the pull to refresh
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: "loadFromNetwork:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refresh, atIndex:0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if let movies = movies{
            return movies.count
        }else{
            return 0
        }
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        let posterPath = movie["poster_path"] as! String
        let baseUrl = "http://image.tmdb.org/t/p/w500/"
        
        let imgUrl = NSURL(string: baseUrl + posterPath)
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        cell.posterView.setImageWithURL(imgUrl!)
        
        //print the value to the console
        print("row  \(indexPath.row)")
        
        return cell
    }
    
    
    func loadFromNetwork(refreshCtrl : UIRefreshControl?){
        //make the network request
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        //show the HUD
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        //do a NSUrl request
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            print("response: \(responseDictionary)")
                            
                            //hide the HUD
                            MBProgressHUD.hideHUDForView(self.view, animated: true)
                            
                            self.movies = responseDictionary["results"] as! [NSDictionary]
                            
                            //reload the data from the table view
                            self.tableView.reloadData()
                            
                            //stop refreshing if there's a refresh control
                            if let refreshCtrl = refreshCtrl{
                                refreshCtrl.endRefreshing()
                            }
                    }
                }
        })
        
        task.resume()
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
