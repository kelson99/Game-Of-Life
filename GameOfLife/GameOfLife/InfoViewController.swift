//
//  InfoViewController.swift
//  GameOfLife
//
//  Created by Kelson Hartle on 10/22/20.
//

import UIKit

class InfoViewController: UIViewController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func wikiLinkTapped(_ sender: UIButton) {
        if let url = URL(string: "https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life") {
            UIApplication.shared.open(url)
        }
    }
}
