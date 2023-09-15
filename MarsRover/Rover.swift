//
//  Rover.swift
//  MarsRover
//
//  Created by Sarthak Agrawal on 15/09/23.
//

import Foundation

class Rover: ObservableObject {
    @Published var x: Int
    @Published var y: Int
    @Published var direction: Direction
    var grid: Grid
    @Published var movement: [String]
    
    init(x: Int, y: Int, direction: Direction, grid: Grid,movement: [String]) {
        self.x = x
        self.y = y
        self.direction = direction
        self.grid = grid
        self.movement = movement
    }
    
    func moveForward() -> Bool {
        var newX = x
        var newY = y
        
        switch direction {
        case .north:
            newY += 1
        case .south:
            newY -= 1
        case .east:
            newX += 1
        case .west:
            newX -= 1
        }
        
        if newX >= 0 && newX < grid.width && newY >= 0 && newY < grid.height && !grid.isObstacle(atX: newX, andY: newY) {
            x = newX
            y = newY
            movement.append("M")
            return true
        }else{
            return false
        }
    }
    
    func turnLeft() {
        switch direction {
        case .north:
            direction = .west
        case .south:
            direction = .east
        case .east:
            direction = .north
        case .west:
            direction = .south
        }
        movement.append("L")
    }
    
    func turnRight() {
        switch direction {
        case .north:
            direction = .east
        case .south:
            direction = .west
        case .east:
            direction = .south
        case .west:
            direction = .north
        }
        movement.append("R")
    }
    
    func reportStatus() -> String {
        return "Current position: (\(x), \(y)), facing: \(direction)"
    }
    
}
