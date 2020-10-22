//
//  InfoViewController.swift
//  GameOfLife
//
//  Created by Kelson Hartle on 10/22/20.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func wikiLinkTapped(_ sender: UIButton) {
        if let url = URL(string: "https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life") {
            UIApplication.shared.open(url)
        }
    }
    
    
}
