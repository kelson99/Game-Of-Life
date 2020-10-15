//
//  Cell.swift
//  GameOfLife
//
//  Created by Kelson Hartle on 10/15/20.
//

import Foundation
class Cell {
    
    var coordinate: Coordinate
    var id: Int
    var left: Cell?
    var right: Cell?
    var bottom: Cell?
    var top: Cell?
    var isSide: Bool
    var isRight: Bool
    var isTop: Bool
    var isBottom: Bool
    var isCorner: Bool
    
    
    init(coordinate: Coordinate, id: Int, isSide: Bool, isRight: Bool, isTop: Bool, isBottom: Bool, isCorner: Bool) {
        self.coordinate = coordinate
        self.id = id
        self.isTop = isTop
        self.isBottom = isBottom
        self.isSide = isSide
        self.isRight = isRight
        self.isCorner = isCorner
    }
}
