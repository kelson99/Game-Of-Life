//
//  MainGameOfLifeViewController.swift
//  GameOfLife
//
//  Created by Kelson Hartle on 10/15/20.
//

import UIKit

class MainGameOfLifeViewController: UIViewController {
    
    enum PresetPattern {
        case Beehive
        case Blinker
        case Toad
        case Beacon
        case Glider
    }
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var firstButton: UIBarButtonItem!
    @IBOutlet weak var secondButton: UIBarButtonItem!
    @IBOutlet weak var thirdButton: UIBarButtonItem!
    @IBOutlet weak var fourthButton: UIBarButtonItem!
    @IBOutlet weak var fithButton: UIBarButtonItem!
    
    
    
    // MARK: - Properties
    let controller = GamePlay()
    let columns = 25
    let rows = 25
    let collectionView = UICollectionView(frame: CGRect(x: 30, y: 300, width: 350, height: 350), collectionViewLayout: UICollectionViewFlowLayout())
    var coordinates: [Cell] = []
    var isRunning: Bool = true
    var timer = Timer()
    var displaySecondArrayCells = true
    var firstTime: Bool = true
    
    
    // MARK: - Private Functions
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
    
    func setUpPreset(presetSelected: PresetPattern) {
        switch presetSelected {
        case .Beehive:
            controller.cellsOne[29].coordinate.status = .alive
            controller.cellsOne[55].coordinate.status = .alive
            controller.cellsOne[56].coordinate.status = .alive
            controller.cellsOne[32].coordinate.status = .alive
            controller.cellsOne[6].coordinate.status = .alive
            controller.cellsOne[5].coordinate.status = .alive
            
            controller.cellsOne[263].coordinate.status = .alive
            controller.cellsOne[262].coordinate.status = .alive
            controller.cellsOne[236].coordinate.status = .alive
            controller.cellsOne[239].coordinate.status = .alive
            controller.cellsOne[213].coordinate.status = .alive
            controller.cellsOne[212].coordinate.status = .alive
        
        case .Beacon:
            controller.cellsOne[133].coordinate.status = .alive
            controller.cellsOne[134].coordinate.status = .alive
            controller.cellsOne[132].coordinate.status = .alive
            
            controller.cellsOne[290].coordinate.status = .alive
            controller.cellsOne[289].coordinate.status = .alive
            controller.cellsOne[288].coordinate.status = .alive
            
            controller.cellsOne[431].coordinate.status = .alive
            controller.cellsOne[430].coordinate.status = .alive
            controller.cellsOne[429].coordinate.status = .alive
            
            controller.cellsOne[568].coordinate.status = .alive
            controller.cellsOne[569].coordinate.status = .alive
            controller.cellsOne[570].coordinate.status = .alive
            
        default:
            fatalError()
        }
        collectionView.reloadData()

    }
    
    func disableButtons() {
        firstButton.isEnabled = false
        secondButton.isEnabled = false
        thirdButton.isEnabled = false
        fourthButton.isEnabled = false
        fithButton.isEnabled = false
    }
    
    func enableButtons() {
        firstButton.isEnabled = true
        secondButton.isEnabled = true
        thirdButton.isEnabled = true
        fourthButton.isEnabled = true
        fithButton.isEnabled = true
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        controller.createCellsInitial()
        controller.createCellsInitialTwo()
        controller.assignNeighbors()
        controller.assignNeighborsTwo()
        createCollectionView()
    }
    
    // MARK: - Actions
    @IBAction func firstPresetTapped(_ sender: Any) {
        // beehive
        setUpPreset(presetSelected: .Beehive)
    }
    
    @IBAction func secondPresetTapped(_ sender: Any) {
        setUpPreset(presetSelected: .Blinker)
    }
    
    @IBAction func thridPresetTapped(_ sender: Any) {
    }
    
    @IBAction func fourthPresetTapepd(_ sender: Any) {
    }
    
    @IBAction func fithPresetTapped(_ sender: Any) {
    }

    @IBAction func stopButtonTapped(_ sender: Any) {
        controller.checkCells()
        collectionView.reloadData()
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        enableButtons()
        if sender.currentTitle == "Stop" {
            sender.setTitle("Start", for: .normal)
            controller.clear()
            timer.invalidate()
            collectionView.reloadData()
        } else {
            disableButtons()
            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { (timer) in
                self.controller.checkCells()
                self.collectionView.reloadData()
                if self.firstTime {
                    self.firstTime = false
                } else {
                    if self.displaySecondArrayCells {
                        self.displaySecondArrayCells = false
                    } else {
                        self.displaySecondArrayCells = true
                    }
                }
            })
            sender.setTitle("Stop", for: .normal)
        }
    }
}

extension MainGameOfLifeViewController:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if displaySecondArrayCells {
            return controller.cellsTwo.count
        } else {
            return controller.cellsOne.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) // as? GameCollectionViewCell ?? GameCollectionViewCell()
        if displaySecondArrayCells {
            if controller.cellsTwo[indexPath.item].coordinate.status == .dead {
                cell.backgroundColor = .none
            } else {
                cell.backgroundColor = .green
            }
        } else {
            if controller.cellsOne[indexPath.item].coordinate.status == .dead {
                cell.backgroundColor = .none
            } else {
                cell.backgroundColor = .green
            }
        }
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.7
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        if let cell = collectionView.cellForItem(at: indexPath) {
            if controller.cellsOne[indexPath.item].coordinate.status == .dead {
                controller.cellsOne[indexPath.item].coordinate.status = .alive
                cell.backgroundColor = .green
            } else {
                controller.cellsOne[indexPath.item].coordinate.status = .dead
                cell.backgroundColor = .none
            }
        }
    }
}
