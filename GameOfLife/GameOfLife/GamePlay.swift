//
//  GamePlay.swift
//  GameOfLife
//
//  Created by Kelson Hartle on 10/15/20.
//

import Foundation

class GamePlay {
    
    // MARK: - Properties
    var cellsOne: [Cell] = []
    var cellsTwo: [Cell] = []
    var useSecondCellsArray: Bool = true
    var firstRound = true
    
    /// This method will create the cells for the first cells array and assign them their appropriate positioning value, by assigning a coordinate
    /// and giving it a boolean value based on its location wether it's on the side, corner etc.
    func createCellsInitial() {
        var id = -1
        var is_row_start = false
        var is_row_end = false
        for one in 0...24 {
            if cellsOne.count == 625 {
                print("BOII")
                break
            }
            is_row_start = true
            for two in 0...24 {
                if two == 24 {
                    is_row_end = true
                }
                id += 1
                if is_row_start {
                    if one == 0 && two == 0 || one == 24 && two == 0 {
                        cellsOne.append(Cell(coordinate: Coordinate(x: one, y: two, status: .dead), id: id, isSide: false, isRight: false, isTop: false, isBottom: false, isCorner: true))
                    } else {
                        cellsOne.append(Cell(coordinate: Coordinate(x: one, y: two, status: .dead), id: id, isSide: true, isRight: false, isTop: false, isBottom: false, isCorner: false))
                    }
                }
                else if is_row_end {
                    if one == 0 && two == 24 || one == 24 && two == 24 {
                        cellsOne.append(Cell(coordinate: Coordinate(x: one, y: two, status: .dead), id: id, isSide: false, isRight: false, isTop: false, isBottom: false, isCorner: true))
                    }
                    else {
                        cellsOne.append(Cell(coordinate: Coordinate(x: one, y: two, status: .dead), id: id, isSide: true, isRight: true, isTop: false, isBottom: false, isCorner: false))
                    }
                }
                else if one - 1 < 0 || one + 1 > 24 {
                    if one - 1 < 0 {
                        cellsOne.append(Cell(coordinate: Coordinate(x: one, y: two, status: .dead), id: id, isSide: false, isRight: false, isTop: true, isBottom: false, isCorner: false))

                    } else {
                        cellsOne.append(Cell(coordinate: Coordinate(x: one, y: two, status: .dead), id: id, isSide: false, isRight: false, isTop: false, isBottom: true, isCorner: false))
                    }
                }
                else {
                    cellsOne.append(Cell(coordinate: Coordinate(x: one, y: two, status: .dead), id: id, isSide: false, isRight: false, isTop: false, isBottom: false, isCorner: false))
                }
                is_row_end = false
                is_row_start = false
            }
        }
    }
    
    /// This method will create the cells for the second cells array and assign them their appropriate positioning value, by assigning a coordinate
    /// and giving it a boolean value based on its location wether it's on the side, corner etc.
    func createCellsInitialTwo() {
        var id = -1
        var is_row_start = false
        var is_row_end = false
        for one in 0...24 {
            if cellsTwo.count == 625 {
                print("BOII")
                break
            }
            is_row_start = true
            for two in 0...24 {
                if two == 24 {
                    is_row_end = true
                }
                id += 1
                if is_row_start {
                    if one == 0 && two == 0 || one == 24 && two == 0 {
                        cellsTwo.append(Cell(coordinate: Coordinate(x: one, y: two, status: .dead), id: id, isSide: false, isRight: false, isTop: false, isBottom: false, isCorner: true))
                    } else {
                        cellsTwo.append(Cell(coordinate: Coordinate(x: one, y: two, status: .dead), id: id, isSide: true, isRight: false, isTop: false, isBottom: false, isCorner: false))
                    }
                }
                else if is_row_end {
                    if one == 0 && two == 24 || one == 24 && two == 24 {
                        cellsTwo.append(Cell(coordinate: Coordinate(x: one, y: two, status: .dead), id: id, isSide: false, isRight: false, isTop: false, isBottom: false, isCorner: true))
                    }
                    else {
                        cellsTwo.append(Cell(coordinate: Coordinate(x: one, y: two, status: .dead), id: id, isSide: true, isRight: true, isTop: false, isBottom: false, isCorner: false))
                    }
                }
                else if one - 1 < 0 || one + 1 > 24 {
                    if one - 1 < 0 {
                        cellsTwo.append(Cell(coordinate: Coordinate(x: one, y: two, status: .dead), id: id, isSide: false, isRight: false, isTop: true, isBottom: false, isCorner: false))

                    } else {
                        cellsTwo.append(Cell(coordinate: Coordinate(x: one, y: two, status: .dead), id: id, isSide: false, isRight: false, isTop: false, isBottom: true, isCorner: false))
                    }
                }
                else {
                    cellsTwo.append(Cell(coordinate: Coordinate(x: one, y: two, status: .dead), id: id, isSide: false, isRight: false, isTop: false, isBottom: false, isCorner: false))
                }
                
                is_row_end = false
                is_row_start = false
            }
        }
    }
    
    /// This function will clear and reset the necessary properties and arrays in order for the simulation to continue on correctly.
    func clear() {
        useSecondCellsArray = true
        firstRound = true
        resetCellsOne()
        resetCellsTwo()
    }
    
    
    /// This function will assign neighbors (aka the surroding cells of each cell) by checking the cell's location and using it's index will locate the appropriate cell and assign as a neighbor (for cellsOne)
    func assignNeighbors() {
        for cell in cellsOne {
            if cell.isCorner {
                if cell.coordinate.x == 0 && cell.coordinate.y == 0 {
                    cell.bottom = cellsOne[cell.id + 25]
                    cell.top = cellsOne[cell.id + 600]
                    cell.left = cellsOne[cell.id + 24]
                    cell.right = cellsOne[cell.id + 1]
                }
                else if cell.coordinate.x == 0 && cell.coordinate.y == 24 {
                    cell.bottom = cellsOne[cell.id + 25]
                    cell.top = cellsOne[cell.id + 600]
                    cell.left = cellsOne[cell.id - 1]
                    cell.right = cellsOne[cell.id - 24]
                    
                }
                else if cell.coordinate.x == 24 && cell.coordinate.y == 0 {
                    cell.bottom = cellsOne[cell.id - 600]
                    cell.top = cellsOne[cell.id - 25]
                    cell.left = cellsOne[cell.id + 24]
                    cell.right = cellsOne[cell.id + 1]
                    
                }
                else if cell.coordinate.x == 24 && cell.coordinate.y == 24 {
                    cell.bottom = cellsOne[cell.id - 600]
                    cell.top = cellsOne[cell.id - 25]
                    cell.left = cellsOne[cell.id - 1 ]
                    cell.right = cellsOne[cell.id - 24]
                }
            }
            else if cell.isTop {
                cell.bottom = cellsOne[cell.id + 25]
                cell.top = cellsOne[cell.id + 600]
                cell.left = cellsOne[cell.id - 1 ]
                cell.right = cellsOne[cell.id + 1]
            }
            else if cell.isBottom {
                cell.bottom = cellsOne[cell.id - 600]
                cell.top = cellsOne[cell.id - 25]
                cell.left = cellsOne[cell.id - 1 ]
                cell.right = cellsOne[cell.id + 1]
            }
            
            else if cell.isSide {
                
                if cell.isRight {
                    cell.bottom = cellsOne[cell.id + 25]
                    cell.top = cellsOne[cell.id - 25]
                    cell.left = cellsOne[cell.id - 1 ]
                    cell.right = cellsOne[cell.id - 24]
                    
                } else {
                    cell.bottom = cellsOne[cell.id + 25]
                    cell.top = cellsOne[cell.id - 25]
                    cell.left = cellsOne[cell.id + 24 ]
                    cell.right = cellsOne[cell.id + 1]
                }
            }
            
            else {
                cell.bottom = cellsOne[cell.id + 25]
                cell.top = cellsOne[cell.id - 25]
                cell.left = cellsOne[cell.id - 1 ]
                cell.right = cellsOne[cell.id + 1]
            }
        }
    }
    
    /// This function will assign neighbors (aka the surroding cells of each cell) by checking the cell's location and using it's index will locate the appropriate cell and assign as a neighbor (for cellsTwo)
    func assignNeighborsTwo() {
        for cell in cellsTwo {
            if cell.isCorner {
                if cell.coordinate.x == 0 && cell.coordinate.y == 0 {
                    cell.bottom = cellsTwo[cell.id + 25]
                    cell.top = cellsTwo[cell.id + 600]
                    cell.left = cellsTwo[cell.id + 24]
                    cell.right = cellsTwo[cell.id + 1]
                }
                else if cell.coordinate.x == 0 && cell.coordinate.y == 24 {
                    cell.bottom = cellsTwo[cell.id + 25]
                    cell.top = cellsTwo[cell.id + 600]
                    cell.left = cellsTwo[cell.id - 1]
                    cell.right = cellsTwo[cell.id - 24]
                    
                }
                else if cell.coordinate.x == 24 && cell.coordinate.y == 0 {
                    cell.bottom = cellsTwo[cell.id - 600]
                    cell.top = cellsTwo[cell.id - 25]
                    cell.left = cellsTwo[cell.id + 24]
                    cell.right = cellsTwo[cell.id + 1]
                    
                }
                else if cell.coordinate.x == 24 && cell.coordinate.y == 24 {
                    cell.bottom = cellsTwo[cell.id - 600]
                    cell.top = cellsTwo[cell.id - 25]
                    cell.left = cellsTwo[cell.id - 1 ]
                    cell.right = cellsTwo[cell.id - 24]
                }
            }
            else if cell.isTop {
                cell.bottom = cellsTwo[cell.id + 25]
                cell.top = cellsTwo[cell.id + 600]
                cell.left = cellsTwo[cell.id - 1 ]
                cell.right = cellsTwo[cell.id + 1]
            }
            else if cell.isBottom {
                cell.bottom = cellsTwo[cell.id - 600]
                cell.top = cellsTwo[cell.id - 25]
                cell.left = cellsTwo[cell.id - 1 ]
                cell.right = cellsTwo[cell.id + 1]
            }
            
            else if cell.isSide {
                
                if cell.isRight {
                    cell.bottom = cellsTwo[cell.id + 25]
                    cell.top = cellsTwo[cell.id - 25]
                    cell.left = cellsTwo[cell.id - 1 ]
                    cell.right = cellsTwo[cell.id - 24]
                    
                } else {
                    cell.bottom = cellsTwo[cell.id + 25]
                    cell.top = cellsTwo[cell.id - 25]
                    cell.left = cellsTwo[cell.id + 24 ]
                    cell.right = cellsTwo[cell.id + 1]
                }
            }
            
            else {
                cell.bottom = cellsTwo[cell.id + 25]
                cell.top = cellsTwo[cell.id - 25]
                cell.left = cellsTwo[cell.id - 1 ]
                cell.right = cellsTwo[cell.id + 1]
            }
        }
    }
    
    /// This function will be used to iterate through the cells in the cellsOne array and determining the next graph simulation to show to the user by storing the information and modifying the cellsTwo array.
    func displayCellsOne () {
        var aliveNeighborCount = 0
        for cell in cellsTwo {
            if cell.coordinate.status == .dead {
                if cell.left?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                if cell.right?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                if cell.top?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                 if cell.bottom?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                 if cell.left?.bottom?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                 if cell.left?.top?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                 if cell.right?.bottom?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                 if cell.right?.top?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                if aliveNeighborCount == 3 {
                    cellsOne[cell.id].coordinate.status = .alive
                    
                } else {
                    cellsOne[cell.id].coordinate.status = .dead
                }
                aliveNeighborCount = 0
            }
            else {
                if cell.left?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                if cell.right?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                if cell.top?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                 if cell.bottom?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                 if cell.left?.bottom?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                 if cell.left?.top?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                 if cell.right?.bottom?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                 if cell.right?.top?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                if aliveNeighborCount == 3 || aliveNeighborCount == 2 {
                    cellsOne[cell.id].coordinate.status = .alive
                } else {
                    cellsOne[cell.id].coordinate.status = .dead
                }
                aliveNeighborCount = 0
            }
        }
    }
    
    /// This function will be used to iterate through the cells in the cellsTwo array and determining the next graph simulation to show to the user by storing the information and modifying the cellsOne array.
    func displayCellsTwo () {
        var aliveNeighborCount = 0
        for cell in cellsOne {
            if cell.coordinate.status == .dead {
                if cell.left?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                if cell.right?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                if cell.top?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                 if cell.bottom?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                 if cell.left?.bottom?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                 if cell.left?.top?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                 if cell.right?.bottom?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                 if cell.right?.top?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                if aliveNeighborCount == 3 {
                    cellsTwo[cell.id].coordinate.status = .alive
                    
                } else {
                    cellsTwo[cell.id].coordinate.status = .dead
                }
                aliveNeighborCount = 0
            }
            else {
                if cell.left?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                if cell.right?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                if cell.top?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                 if cell.bottom?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                 if cell.left?.bottom?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                 if cell.left?.top?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                 if cell.right?.bottom?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                 if cell.right?.top?.coordinate.status == .alive {
                    aliveNeighborCount += 1
                }
                if aliveNeighborCount == 3 || aliveNeighborCount == 2 {
                    cellsTwo[cell.id].coordinate.status = .alive
                } else {
                    cellsTwo[cell.id].coordinate.status = .dead
                }
                aliveNeighborCount = 0
            }
        }
    }
    
    /// This function will check the necessary properties for every time the cells are checked and mofify as necessary.
    func checkCells() {
        if firstRound {
            firstRound = false
        } else {
            if useSecondCellsArray {
                resetCellsTwo()
            } else {
                resetCellsOne()
            }
        }
        
        if useSecondCellsArray {
            displayCellsTwo()
        } else {
            displayCellsOne()
        }
        
        if useSecondCellsArray {
            useSecondCellsArray = false
        } else {
            useSecondCellsArray = true
        }
    }
    
    /// Resets the cells one array by looping through and changing each cell property to dead
    func resetCellsOne() {
        for cell in cellsOne {
            cell.coordinate.status = .dead
        }
    }
    
    /// Resets the cells two array by looping through and changing each cell property to dead
    func resetCellsTwo() {
        for cell in cellsTwo {
            cell.coordinate.status = .dead
        }
    }
}
