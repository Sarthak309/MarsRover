//
//  Command.swift
//  MarsRover
//
//  Created by Sarthak Agrawal on 15/09/23.
//

import Foundation

protocol Command {
    func execute(rover: Rover) -> Bool
}

class MoveForwardCommand: Command {
    
    func execute(rover: Rover) -> Bool {
        return rover.moveForward()
    }
}

class TurnLeftCommand: Command {
    func execute(rover: Rover) -> Bool {
        rover.turnLeft()
        return true
    }
}

class TurnRightCommand: Command {
    
    func execute(rover: Rover) -> Bool {
        rover.turnRight()
        return true
    }
}
