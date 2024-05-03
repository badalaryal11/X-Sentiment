//
//  ViewController.swift
//  X-Sentiment
//
//  Created by Badal  Aryal on 26/04/2024.
//

import UIKit
import SwifteriOS

class ViewController: UIViewController {
    
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let swifter = Swifter(consumerKey: "rMqIfXmYxTiI3ZUnyydL5xWrk", consumerSecret: "PTIAO3p6ltw7JcMHTTDsqqbhZFzmwjzUI9U7ekaq8nPCj3xU9R")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        swifter.searchTweet(using: "@Apple", success: { results, metadata in
            print(results)
        }) {(error) in
            print("There was an error with the twitter API Request, \(error)")
        }
    }


    @IBAction func predictPressed(_ sender: UIButton!) {
    }
}

