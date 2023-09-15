import SwiftUI


struct SetupView: View {
    @State var rover = Rover(x: 0, y: 0, direction: .north, grid: Grid(width: 5, height: 5, obstacles: []),movement: [])
    @State var startX: String = ""
    @State var startY: String = ""
    @State var direction: String = ""
    @State var obstacleX: String = ""
    @State var obstacleY: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Starting X position", text: $startX)
                    .frame(maxWidth: .infinity)
                    .border(.black)
                    .buttonBorderShape(.capsule)
//                    .cornerRadius(10)
                TextField("Starting Y position", text: $startY)
                TextField("Direction (N, S, E, W)", text: $direction)
                TextField("Obstacle X position", text: $obstacleX)
                TextField("Obstacle Y position", text: $obstacleY)
                NavigationLink(destination: ContentView(rover: rover)) {
                    Text("Set up rover")
                }
                .onAppear {
                    if let startX = Int(self.startX), let startY = Int(self.startY), let obstacleX = Int(self.obstacleX), let obstacleY = Int(self.obstacleY) {
                        self.rover.x = startX
                        self.rover.y = startY
                        self.rover.grid.obstacles.append((obstacleX, obstacleY))
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
                        }
                    }
                }
            }
            .foregroundColor(.black)
            .padding()
        }
    }
}

struct setupPreview: PreviewProvider{
    
    static var previews: some View{
        SetupView()
    }
}


