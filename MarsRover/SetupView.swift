//
//  SetupView.swift
//  MarsRover
//
//  Created by Sarthak Agrawal on 16/09/23.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .foregroundColor(.black)
    }
}

struct SetupView: View {
    @State var rover = Rover(x: 0, y: 0, direction: .north, grid: Grid(width: 10, height: 10, obstacles: []),movement: [])
    @State var startX: String = ""
    @State var startY: String = ""
    @State var direction: String = ""
    @State var obstacleX: String = ""
    @State var obstacleY: String = ""
    @State var obstacles: [(Int, Int)] = []
    @State var movements: String = ""
    @State var navigate = false
    @State var showAlert = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image("compass")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding(.top,-130)
                }
                Divider()
                VStack{
                    VStack(spacing: 10){
                        TextField("Starting X position", text: $startX)
                            .textFieldStyle(CustomTextFieldStyle())
                        TextField("Starting Y position", text: $startY)
                            .textFieldStyle(CustomTextFieldStyle())
                        TextField("Direction (N, S, E, W)", text: $direction)
                            .textFieldStyle(CustomTextFieldStyle())
                        TextField("Obstacle X position", text: $obstacleX)
                            .textFieldStyle(CustomTextFieldStyle())
                        TextField("Obstacle Y position", text: $obstacleY)
                            .textFieldStyle(CustomTextFieldStyle())
                        TextField("Movements (space-separated M, L, R)", text: $movements)
                            .textFieldStyle(CustomTextFieldStyle())
                    }
                    .padding(.bottom,15)
                    Divider()
                    Button(action: {
                        if let obstacleX = Int(self.obstacleX), let obstacleY = Int(self.obstacleY) {
                            self.obstacles.append((obstacleX, obstacleY))
                            self.obstacleX = ""
                            self.obstacleY = ""
                        }
                    }) {
                        Text("Add Obstacle")
                            .padding(.bottom,10)
                    }
                    Button(action: {
                        if let startX = Int(self.startX), let startY = Int(self.startY) {
                            self.rover.x = startX
                            self.rover.y = startY
                            self.rover.grid.obstacles = self.obstacles
                            switch self.direction.uppercased() {
                            case "N":
                                self.rover.direction = .north
                            case "S":
                                self.rover.direction = .south
                            case "E":
                                self.rover.direction = .east
                            case "W":
                                self.rover.direction = .west
                            default:
                                break
//                                showAlert = true
                            }
                            self.rover.movement = self.movements.split(separator: " ").map { String($0) }
                            self.navigate = true
                        }
                        if(!rover.movement.isEmpty){
                            moving = true
                        }
                    }) {
                        Text("Set up rover")
                    }
                    NavigationLink(destination: ContentView(rover: rover), isActive: $navigate) {
                        EmptyView()
                    }
                }
//                .alert(isPresented: $showAlert) {
//                    Alert(title: Text("Wrong Direction"), message: Text("You have entered a Wrong Direction, choose only from N, S, E, W"), dismissButton: .default(Text("OK")))
//                }
                .padding()
            }
        }
    }
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        SetupView()
    }
}
