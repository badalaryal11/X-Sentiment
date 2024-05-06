//
//  ViewController.swift
//  X-Sentiment
//
//  Created by Badal  Aryal on 26/04/2024.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController {
    
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let sentimentClassifier = X_SentimentClassifier()
    
    let swifter = Swifter(consumerKey: "rMqIfXmYxTiI3ZUnyydL5xWrk", consumerSecret: "PTIAO3p6ltw7JcMHTTDsqqbhZFzmwjzUI9U7ekaq8nPCj3xU9R")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//      let prediction = try! sentimentClassifier.prediction(text: "@Apple is the best Company.")
//        print(prediction.label)
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended, success: { (results, metadata) in
            
            var tweets = [String]()
            
            for i in 0..<100 {
                if  let tweet = results[i]["full_text"].string {
                    tweets.append(tweet)
                    
                }
            }
          
            print(tweets)
            
        }) {(error) in
            print("There was an error with the twitter API Request, \(error)")
        }
    }


    @IBAction func predictPressed(_ sender: UIButton!) {
    }
}

