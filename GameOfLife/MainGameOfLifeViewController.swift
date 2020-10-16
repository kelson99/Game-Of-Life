//
//  MainGameOfLifeViewController.swift
//  GameOfLife
//
//  Created by Kelson Hartle on 10/15/20.
//

import UIKit

class MainGameOfLifeViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    let controller = GamePlay()
    let columns = 25
    let rows = 25
    let collectionView = UICollectionView(frame: CGRect(x: 30, y: 300, width: 350, height: 350), collectionViewLayout: UICollectionViewFlowLayout())
    var coordinates: [Cell] = []
    var isRunning: Bool = true
    var timer = Timer()
    
    func createCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let rectangle = CGRect(x: 30, y: 300, width: 350, height: 350)
        collectionView.collectionViewLayout = flowLayout
        collectionView.frame = rectangle
        let width = collectionView.frame.size.width / CGFloat(columns)
        let height = collectionView.frame.size.width / CGFloat(columns)
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        self.view.addSubview(collectionView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        controller.createCellsInitial()
        controller.assignNeighbors()
        createCollectionView()
    }
    @IBAction func stopButtonTapped(_ sender: Any) {
        isRunning = false
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        var ount = 0
        if sender.currentTitle == "Stop" {
            sender.setTitle("Start", for: .normal)
            controller.clear()
            timer.invalidate()
            collectionView.reloadData()
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { (timer) in
                
                self.controller.checkCells()
                self.collectionView.reloadData()
            })
            sender.setTitle("Stop", for: .normal)
        }
    }
    
    func doThatTHing() {
        if playButton.currentTitle == "Stop" {
            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { (timer) in
                
                self.collectionView.reloadData()
            })
        } else {
            playButton.setTitle("Start", for: .normal)
        }
    }
}

extension MainGameOfLifeViewController:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controller.cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) // as? GameCollectionViewCell ?? GameCollectionViewCell()
        if controller.cells[indexPath.item].coordinate.status == .dead {
            cell.backgroundColor = .none
        } else {
            cell.backgroundColor = .green
        }
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.7
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.layer.backgroundColor = .none
            if controller.cells[indexPath.item].coordinate.status == .dead {
                controller.cells[indexPath.item].coordinate.status = .alive
                cell.backgroundColor = .green
            } else {
                controller.cells[indexPath.item].coordinate.status = .dead
                cell.backgroundColor = .none
            }
        }
    }
}
