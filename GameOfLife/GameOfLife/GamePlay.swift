//
//  GamePlay.swift
//  GameOfLife
//
//  Created by Kelson Hartle on 10/15/20.
//

import Foundation

class GamePlay {
    
    var cells: [Cell] = []
    var count_a = 0
    var count_b = 0
    
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
//
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
        }
    }
    
    func checkCells() {
        /*
         top - M : x - 0 , y-1
         top - L : x - 1 , y-1
         top - R : x + 1 , y-1
         Left : x - 1 , y - 0
         Right - M : x + 1 , y - 0
         Bottom - L : x - 1 , y + 1
         bottom - M : x - 0 , y + 1
         bottom - R : x + 1 , y + 1
         */
        var aliveNeighborCount = 0
        for cell in cells {
            cells[10].coordinate.status = .alive
            cells[3].coordinate.status = .alive
            
            if cell.left?.coordinate.status == .alive {
                aliveNeighborCount += 1
            }
            else if cell.right?.coordinate.status == .alive {
                aliveNeighborCount += 1
            }
            else if cell.top?.coordinate.status == .alive {
                aliveNeighborCount += 1
            }
            else if cell.bottom?.coordinate.status == .alive {
                aliveNeighborCount += 1
            }
            else if cell.left?.bottom?.coordinate.status == .alive {
                aliveNeighborCount += 1
            }
            else if cell.left?.top?.coordinate.status == .alive {
                aliveNeighborCount += 1
            }
            else if cell.right?.bottom?.coordinate.status == .alive {
                aliveNeighborCount += 1
            }
            else if cell.right?.bottom?.coordinate.status == .alive {
                aliveNeighborCount += 1
            }
            else {
                print("DEAD")
            }
            
            if aliveNeighborCount >= 1 {
                print("WAP")
            }
            
            print(cell.coordinate)
            print(aliveNeighborCount)
        }
    }
}
