
import SwiftUI

struct ContentView: View {
    
    // The Navigation is Based on the State of the Game
    // Each State Represents a Different View
    
    // Variable to Switch Between Views
    @State var currentGameState: GameState = .comic
    
    // Variable to Transfer ModesViewModel Data to Other Views
    @State var currentModesViewModelState: ModesViewModel = ModesViewModel()

    var body: some View {
        
        switch currentGameState {
            
        case .comic:
            ComicView(currentGameState: $currentGameState, currentModesViewModelState: $currentModesViewModelState)
            
        case .intro:
            IntroView(currentGameState: $currentGameState, currentModesViewModelState: $currentModesViewModelState)
            
        case .variables:
            VariablesView(currentGameState: $currentGameState, currentModesViewModelState: $currentModesViewModelState)
            
        case .loopArray:
            LoopArrayView(currentGameState: $currentGameState, currentModesViewModelState: $currentModesViewModelState)
            
        case .functions:
            FunctionsView(currentGameState: $currentGameState, currentModesViewModelState: $currentModesViewModelState)
            
        case .ending:
            EndingView(currentGameState: $currentGameState, currentModesViewModelState: $currentModesViewModelState)
        }
        
    }
}

#Preview {
    ContentView()
}
