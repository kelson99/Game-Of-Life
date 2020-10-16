//
//  GamePlay.swift
//  GameOfLife
//
//  Created by Kelson Hartle on 10/15/20.
//

import Foundation

class GamePlay {
    
    var cells: [Cell] = []
    
    func createCellsInitial() {
        var id = -1
        var is_row_start = false
        var is_row_end = false
        for one in 0...24 {
            if cells.count == 625 {
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
                        cells.append(Cell(coordinate: Coordinate(x: one, y: two, status: .dead), id: id, isSide: false, isRight: false, isTop: false, isBottom: false, isCorner: true))
                    } else {
                        cells.append(Cell(coordinate: Coordinate(x: one, y: two, status: .dead), id: id, isSide: true, isRight: false, isTop: false, isBottom: false, isCorner: false))
                    }
                }
                else if is_row_end {
                    if one == 0 && two == 24 || one == 24 && two == 24 {
                        cells.append(Cell(coordinate: Coordinate(x: one, y: two, status: .dead), id: id, isSide: false, isRight: false, isTop: false, isBottom: false, isCorner: true))
                    }
                    else {
                        cells.append(Cell(coordinate: Coordinate(x: one, y: two, status: .dead), id: id, isSide: true, isRight: true, isTop: false, isBottom: false, isCorner: false))
                    }
                }
                else if one - 1 < 0 || one + 1 > 24 {
                    if one - 1 < 0 {
                        cells.append(Cell(coordinate: Coordinate(x: one, y: two, status: .dead), id: id, isSide: false, isRight: false, isTop: true, isBottom: false, isCorner: false))

                    } else {
                        cells.append(Cell(coordinate: Coordinate(x: one, y: two, status: .dead), id: id, isSide: false, isRight: false, isTop: false, isBottom: true, isCorner: false))
                    }
                }
                else {
                    cells.append(Cell(coordinate: Coordinate(x: one, y: two, status: .dead), id: id, isSide: false, isRight: false, isTop: false, isBottom: false, isCorner: false))
                }
                
                is_row_end = false
                is_row_start = false
            }
        }
    }
    
    func clear() {
        for cell in cells {
            cell.coordinate.status = .dead
        }
    }
    
    func assignNeighbors() {
        for cell in cells {
            if cell.isCorner {
                if cell.coordinate.x == 0 && cell.coordinate.y == 0 {
                    cell.bottom = cells[cell.id + 25]
                    cell.top = cells[cell.id + 600]
                    cell.left = cells[cell.id + 24]
                    cell.right = cells[cell.id + 1]
                }
                else if cell.coordinate.x == 0 && cell.coordinate.y == 24 {
                    cell.bottom = cells[cell.id + 25]
                    cell.top = cells[cell.id + 600]
                    cell.left = cells[cell.id - 1]
                    cell.right = cells[cell.id - 24]
                    
                }
                else if cell.coordinate.x == 24 && cell.coordinate.y == 0 {
                    cell.bottom = cells[cell.id - 600]
                    cell.top = cells[cell.id - 25]
                    cell.left = cells[cell.id + 24]
                    cell.right = cells[cell.id + 1]
                    
                }
                else if cell.coordinate.x == 24 && cell.coordinate.y == 24 {
                    cell.bottom = cells[cell.id - 600]
                    cell.top = cells[cell.id - 25]
                    cell.left = cells[cell.id - 1 ]
                    cell.right = cells[cell.id - 24]
//                        print("\(cell.left?.coordinate) \(cell.right?.coordinate) \(cell.top?.coordinate) \(cell.bottom?.coordinate)")
                }
            }
            else if cell.isTop {
                cell.bottom = cells[cell.id + 25]
                cell.top = cells[cell.id + 600]
                cell.left = cells[cell.id - 1 ]
                cell.right = cells[cell.id + 1]
            }
            else if cell.isBottom {
                cell.bottom = cells[cell.id - 600]
                cell.top = cells[cell.id - 25]
                cell.left = cells[cell.id - 1 ]
                cell.right = cells[cell.id + 1]
            }
            
            else if cell.isSide {
                
                if cell.isRight {
                    cell.bottom = cells[cell.id + 25]
                    cell.top = cells[cell.id - 25]
                    cell.left = cells[cell.id - 1 ]
                    cell.right = cells[cell.id - 24]
                    
                } else {
                    cell.bottom = cells[cell.id + 25]
                    cell.top = cells[cell.id - 25]
                    cell.left = cells[cell.id + 24 ]
                    cell.right = cells[cell.id + 1]
                }
                
//                    print("\(cell.left?.coordinate) \(cell.right) \(cell.top) \(cell.bottom)")
//                    print("Cell Coordinates: \(cell.coordinate) Cell ID: \(cell.id) --- Cell Left \(cell.left!.coordinate) Cell ID: \(cell.left!.id)")
            }
            
            else {
                cell.bottom = cells[cell.id + 25]
                cell.top = cells[cell.id - 25]
                cell.left = cells[cell.id - 1 ]
                cell.right = cells[cell.id + 1]
            }
        }
    }
    
    func checkCells() {
//        If the cell is alive and has 2 or 3 neighbors, then it remains alive. Else it dies.
        var aliveNeighborCount = 0
        let allLiveCells = cells.filter({$0.coordinate.status == .alive})
        for cell in cells {
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
                    cell.coordinate.status = .alive
                } else {
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
                    cell.coordinate.status = .alive
                } else {
                    cell.coordinate.status = .dead
                }
                aliveNeighborCount = 0
            }
        }
    }
}
