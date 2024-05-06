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
    
    let tweetCount = 100
    
    let sentimentClassifier = X_SentimentClassifier()
    
    let swifter = Swifter(consumerKey: "rMqIfXmYxTiI3ZUnyydL5xWrk", consumerSecret: "PTIAO3p6ltw7JcMHTTDsqqbhZFzmwjzUI9U7ekaq8nPCj3xU9R")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func predictPressed(_ sender: UIButton!) {
        fetchTweets()
       
        
    }
    func fetchTweets() {
        
        if let searchText = textField.text {
            //      let prediction = try! sentimentClassifier.prediction(text: "@Apple is the best Company.")
            //        print(prediction.label)
            swifter.searchTweet(using: searchText, lang: "en", count: tweetCount, tweetMode: .extended, success: { (results, metadata) in
                
                var tweets = [X_SentimentClassifierInput]()
                
                for i in 0..<self.tweetCount {
                    if  let tweet = results[i]["full_text"].string {
                        let tweetForClassification = X_SentimentClassifierInput(text: tweet)
                        tweets.append(tweetForClassification)
                        
                    }
                }
                self.makePrediction(with: tweets) // method in current class
                
            }) {(error) in
                print("There was an error with the twitter API Request, \(error)")
            }
            
        }
        
    }
    func makePrediction(with tweets: [X_SentimentClassifierInput]) {
        
        do {
            let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
            var sentimentScore = 0
            
            for pred in predictions {
                let sentiment = pred.label
                
                if sentiment == "Pos" {
                    sentimentScore += 1
                    
                }else if sentiment == "Neg" {
                    sentimentScore -= 1
                }
                
                UpdateUI(with: sentimentScore)
                
            }
            
            
        } catch {
            print("There was an error with making a prediction, \(error)")
        }
        
        
    }
    func UpdateUI(with sentimentScore: Int) {
        
        if sentimentScore > 20 {
            self.sentimentLabel.text = "😍"
        } else if sentimentScore > 10{
            self.sentimentLabel.text = "😃"
        } else if sentimentScore > 0 {
            self.sentimentLabel.text = "🙂"
            
        } else if sentimentScore == 0 {
            self.sentimentLabel.text = "😐"
            
        } else if sentimentScore > -10 {
            self.sentimentLabel.text = "😬"
        } else if sentimentScore > -20 {
            self.sentimentLabel.text = "😡"
        } else {
            self.sentimentLabel.text = "🤑"
        }
        
        
        
    }
}

