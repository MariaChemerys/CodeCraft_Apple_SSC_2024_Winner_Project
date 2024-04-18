
import Foundation

class ModesViewModel: ObservableObject{
    
    // Variable to Switch Between ENG and UA Languages
    @Published var isENG: Bool
    
    // Variable to Enable/Disable High Contrast Mode
    @Published var highContrastModeON: Bool
    
    // Variable to Regulate the Speaking Rate for the Text-to-Speech Functionality
    @Published var speakingRate: Float
    
    // Initializer
    init(){
        isENG = true
        highContrastModeON = false
        speakingRate = 0.5
    }
    
}

// enum for the Navigation Between the Views
enum GameState{
    case comic // ComicView
    case intro // IntroView
    case variables // VariablesView
    case loopArray // LoopArrayView
    case functions // FunctionsView
    case ending // EndingView
}
