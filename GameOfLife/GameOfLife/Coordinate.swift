//
//  Coordinate.swift
//  GameOfLife
//
//  Created by Kelson Hartle on 10/15/20.
//

import Foundation
struct Coordinate {
    enum Status {
        case alive
        case dead
    }
    var x: Int
    var y: Int
    var status: Status
}

