import SwiftUI
var moving = false

struct ContentView: View {
    @StateObject var rover = Rover(x: 0, y: 0, direction: .north, grid: Grid(width: 10, height: 10, obstacles: [(2,2),(3,5)]),movement: [])
        
    @State var showAlert = false
    var body: some View {
        VStack {
//            Spacer()
            HStack {
                //                Spacer(minLength: 10)
                Image("compass")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding(.top,-150)
            }
            Divider()
            GridView(rover: rover)
            Text(rover.reportStatus())
                .padding(.top,6)
            Text("Movements: \(rover.movement.joined(separator: ", "))")
                .padding(.vertical,10)
            Divider()
            HStack(spacing: 10) {
                Button(action: {
                    rover.turnLeft()
                }) {
                    Text("Turn Left")
                }
                Button(action: {
                    if !rover.moveForward(){
                        self.showAlert  = true
                    }
                }) {
                    Text("Move Forward")
                }
                .alert( isPresented: $showAlert) {
                    Alert(title: Text("Cannot Move"), message: Text("The rover cannot move forward because either there is an obstacle in the way or the rover is about to exit the grid."), dismissButton: .default(Text("OK")))
                }
                Button(action: {
                    rover.turnRight()
                }) {
                    Text("Turn Right")
                }
            }
            .padding(.top,10)
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            while(!rover.movement.isEmpty && moving){
                for move in rover.movement{
                    switch move{
                    case "M":
                        if rover.moveForward(){}
                    case "L":
                        rover.turnLeft()
                    case "R":
                        rover.turnRight()
                    default:
                        break
                    }
                    rover.movement.removeFirst(1)
                    
                }
                moving = false
            }
        }
    }
}

struct GridView: View {
    @ObservedObject var rover: Rover

    var body: some View {
        ForEach((0..<rover.grid.height).reversed(), id: \.self) { row in
            HStack {
                ForEach(0..<rover.grid.width, id: \.self) { column in
                    if self.rover.x == column && self.rover.y == row {
                        Text(" R ")
                    } else if self.rover.grid.isObstacle(atX: column, andY: row) {
                        Text(" O ")
                    } else {
                        Text(" - ")
                    }
                }
            }
        }
    }
}

struct preview: PreviewProvider{
    
    static var previews: some View{
        ContentView()
    }
}
