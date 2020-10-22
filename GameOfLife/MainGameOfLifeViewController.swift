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
        case Pulsar
        case SpaceShip
    }
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var firstButton: UIBarButtonItem!
    @IBOutlet weak var secondButton: UIBarButtonItem!
    @IBOutlet weak var thirdButton: UIBarButtonItem!
    @IBOutlet weak var fourthButton: UIBarButtonItem!
    @IBOutlet weak var fithButton: UIBarButtonItem!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var iterationsLabel: UILabel!
    
    
    
    // MARK: - Properties
    let controller = GamePlay()
    let columns = 25
    let rows = 25
    let collectionView = UICollectionView(frame: CGRect(x: 30, y: 300, width: 350, height: 350), collectionViewLayout: UICollectionViewFlowLayout())
    var coordinates: [Cell] = []
    var timer = Timer()
    var displaySecondArrayCells = true
    var firstTime: Bool = true
    var iterationsCount = 0
    
    
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
        collectionView.backgroundColor = .gray
        
        self.view.addSubview(collectionView)
    }
    
    func reloadCollectionToViewPreset() {
        defer {displaySecondArrayCells = true}
        displaySecondArrayCells = false
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func disableButtons() {
        firstButton.isEnabled = false
        secondButton.isEnabled = false
        thirdButton.isEnabled = false
        fourthButton.isEnabled = false
        fithButton.isEnabled = false
        nextButton.isEnabled = false
    }
    
    func enableButtons() {
        firstButton.isEnabled = true
        secondButton.isEnabled = true
        thirdButton.isEnabled = true
        fourthButton.isEnabled = true
        fithButton.isEnabled = true
        nextButton.isEnabled = true
    }
    
    func reset() {
        iterationsCount = 0
        self.iterationsLabel.text = "Iterations# 0"
        self.displaySecondArrayCells = true
        controller.clear()
        timer.invalidate()
        collectionView.reloadData()
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
        let arr = (1...80).map({_ in Int.random(in: 1...500)})
        for x in arr {
            controller.cellsOne[x].coordinate.status = .alive
        }
    }
    
    @IBAction func secondPresetTapped(_ sender: Any) {
        setUpPreset(presetSelected: .Blinker)
    }
    
    @IBAction func thridPresetTapped(_ sender: Any) {
        setUpPreset(presetSelected: .Glider)
    }
    
    @IBAction func fourthPresetTapepd(_ sender: Any) {
        setUpPreset(presetSelected: .Pulsar)
    }
    
    @IBAction func fithPresetTapped(_ sender: Any) {
        setUpPreset(presetSelected: .SpaceShip)
    }
    
    @IBAction func stopButtonTapped(_ sender: Any) {
        self.iterationsCount += 1
        self.iterationsLabel.text = "Iterations# \(self.iterationsCount)"
        controller.checkCells()
        collectionView.reloadData()
        if self.displaySecondArrayCells {
            self.displaySecondArrayCells = false
        } else {
            self.displaySecondArrayCells = true
        }
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        enableButtons()
        if sender.currentTitle == "Stop" {
            //self.firstTime = true
            sender.setTitle("Start", for: .normal)
            reset()
            
        } else {
            disableButtons()
            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { (timer) in
                self.iterationsCount += 1
                self.iterationsLabel.text = "Iterations# \(self.iterationsCount)"
                self.controller.checkCells()
                self.collectionView.reloadData()
                if self.displaySecondArrayCells {
                    self.displaySecondArrayCells = false
                } else {
                    self.displaySecondArrayCells = true
                }
            })
            sender.setTitle("Stop", for: .normal)
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        reset()
    }
    
    @IBAction func infoButtonTapped(_ sender: Any) {
        
    }
    
}

extension MainGameOfLifeViewController:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if firstTime {
            firstTime = false
            return 625
        } else {
            if displaySecondArrayCells {
                //print("SECOND")
                return controller.cellsTwo.count
            } else {
                //print("FIRST")
                return controller.cellsOne.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) // as? GameCollectionViewCell ?? GameCollectionViewCell()
        if displaySecondArrayCells {
            //print("Second")
            if controller.cellsTwo[indexPath.item].coordinate.status == .dead {
                cell.backgroundColor = .none
            } else {
                cell.backgroundColor = .green
            }
        } else {
            //print("First")
            if controller.cellsOne[indexPath.item].coordinate.status == .dead {
                cell.backgroundColor = .none
            } else {
                cell.backgroundColor = .green
            }
        }
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.borderWidth = 0.7
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        if displaySecondArrayCells {
            if let cell = collectionView.cellForItem(at: indexPath) {
                if controller.cellsOne[indexPath.item].coordinate.status == .dead {
                    controller.cellsOne[indexPath.item].coordinate.status = .alive
                    cell.backgroundColor = .green
                } else {
                    controller.cellsOne[indexPath.item].coordinate.status = .dead
                    cell.backgroundColor = .none
                }
            }
        } else {
            if let cell = collectionView.cellForItem(at: indexPath) {
                if controller.cellsTwo[indexPath.item].coordinate.status == .dead {
                    controller.cellsTwo[indexPath.item].coordinate.status = .alive
                    cell.backgroundColor = .green
                } else {
                    controller.cellsTwo[indexPath.item].coordinate.status = .dead
                    cell.backgroundColor = .none
                }
            }
        }
    }
}

extension MainGameOfLifeViewController {
    func setUpPreset(presetSelected: PresetPattern) {
        controller.clear()
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
            
        case .Blinker:
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
            
        case .Glider:
            controller.cellsOne[338].coordinate.status = .alive
            controller.cellsOne[364].coordinate.status = .alive
            controller.cellsOne[389].coordinate.status = .alive
            controller.cellsOne[388].coordinate.status = .alive
            controller.cellsOne[387].coordinate.status = .alive
            
        case .Pulsar:
            controller.cellsOne[128].coordinate.status = .alive
            controller.cellsOne[129].coordinate.status = .alive
            controller.cellsOne[130].coordinate.status = .alive
            controller.cellsOne[155].coordinate.status = .alive
            controller.cellsOne[255].coordinate.status = .alive
            controller.cellsOne[280].coordinate.status = .alive
            controller.cellsOne[279].coordinate.status = .alive
            controller.cellsOne[278].coordinate.status = .alive
            controller.cellsOne[257].coordinate.status = .alive
            controller.cellsOne[232].coordinate.status = .alive
            controller.cellsOne[233].coordinate.status = .alive
            controller.cellsOne[283].coordinate.status = .alive
            controller.cellsOne[284].coordinate.status = .alive
            controller.cellsOne[259].coordinate.status = .alive
            controller.cellsOne[261].coordinate.status = .alive
            controller.cellsOne[286].coordinate.status = .alive
            controller.cellsOne[287].coordinate.status = .alive
            controller.cellsOne[237].coordinate.status = .alive
            controller.cellsOne[238].coordinate.status = .alive
            controller.cellsOne[263].coordinate.status = .alive
            controller.cellsOne[332].coordinate.status = .alive
            controller.cellsOne[333].coordinate.status = .alive
            controller.cellsOne[357].coordinate.status = .alive
            controller.cellsOne[382].coordinate.status = .alive
            controller.cellsOne[337].coordinate.status = .alive
            controller.cellsOne[338].coordinate.status = .alive
            controller.cellsOne[363].coordinate.status = .alive
            controller.cellsOne[388].coordinate.status = .alive
            controller.cellsOne[290].coordinate.status = .alive
            controller.cellsOne[291].coordinate.status = .alive
            controller.cellsOne[292].coordinate.status = .alive
            controller.cellsOne[265].coordinate.status = .alive
            controller.cellsOne[165].coordinate.status = .alive
            controller.cellsOne[140].coordinate.status = .alive
            controller.cellsOne[141].coordinate.status = .alive
            controller.cellsOne[142].coordinate.status = .alive
            controller.cellsOne[182].coordinate.status = .alive
            controller.cellsOne[183].coordinate.status = .alive
            controller.cellsOne[157].coordinate.status = .alive
            controller.cellsOne[133].coordinate.status = .alive
            controller.cellsOne[134].coordinate.status = .alive
            controller.cellsOne[159].coordinate.status = .alive
            controller.cellsOne[136].coordinate.status = .alive
            controller.cellsOne[137].coordinate.status = .alive
            controller.cellsOne[161].coordinate.status = .alive
            controller.cellsOne[187].coordinate.status = .alive
            controller.cellsOne[188].coordinate.status = .alive
            controller.cellsOne[163].coordinate.status = .alive
            controller.cellsOne[83].coordinate.status = .alive
            controller.cellsOne[82].coordinate.status = .alive
            controller.cellsOne[57].coordinate.status = .alive
            controller.cellsOne[32].coordinate.status = .alive
            controller.cellsOne[87].coordinate.status = .alive
            controller.cellsOne[88].coordinate.status = .alive
            controller.cellsOne[63].coordinate.status = .alive
            controller.cellsOne[38].coordinate.status = .alive
            
        case .SpaceShip:
            controller.cellsOne[183].coordinate.status = .alive
            controller.cellsOne[159].coordinate.status = .alive
            controller.cellsOne[160].coordinate.status = .alive
            controller.cellsOne[161].coordinate.status = .alive
            controller.cellsOne[162].coordinate.status = .alive
            controller.cellsOne[163].coordinate.status = .alive
            controller.cellsOne[188].coordinate.status = .alive
            controller.cellsOne[213].coordinate.status = .alive
            controller.cellsOne[237].coordinate.status = .alive
            controller.cellsOne[260].coordinate.status = .alive
            controller.cellsOne[233].coordinate.status = .alive
            
        default:
            fatalError()
        }
        reloadCollectionToViewPreset()
    }
}
