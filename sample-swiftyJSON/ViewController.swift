//
//  ViewController.swift
//  sample-swiftyJSON
//
//  Created by MGXA2 on 2/28/17.
//  Copyright © 2017 Duc Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var objects = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=3&offset=0&createdBefore=1352924535"
        
        if let url = NSURL(string: urlString) {
            if let data = try? NSData(contentsOf: url as URL, options: []) {
                let json = JSON(data: data as Data)
                
                
                if json["metadata"]["responseInfo"]["status"].intValue == 200 {
                    parseJSON(json: json)
                } else {
                    showError()
                }
            } else {
                showError()
            }
        } else {
            showError()
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    func parseJSON(json: JSON) {
        for result in json["results"].arrayValue {
            let title = result["title"].stringValue
            let body = result["body"].stringValue
            let sigs = result["signatureCount"].stringValue
            let obj = ["title": title, "body": body, "sigs": sigs]
            objects.append(obj)
        }
        let count = json["metadata"]["resultset"]["count"].intValue
        let limit = json["metadata"]["resultset"]["limit"].intValue
        let offset = json["metadata"]["resultset"]["offset"].intValue
        print("count = \(count) limit = \(limit) offset = \(offset)")
        print(objects)
    }


}

