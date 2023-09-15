//
//  Grid.swift
//  MarsRover
//
//  Created by Sarthak Agrawal on 15/09/23.
//

import Foundation

class Grid {
    var width: Int
    var height: Int
    var obstacles: [(Int, Int)]

    init(width: Int, height: Int, obstacles: [(Int, Int)]) {
        self.width = width
        self.height = height
        self.obstacles = obstacles
    }

    func isObstacle(atX x: Int, andY y: Int) -> Bool {
        return obstacles.contains(where: { $0.0 == x && $0.1 == y })
    }
}
