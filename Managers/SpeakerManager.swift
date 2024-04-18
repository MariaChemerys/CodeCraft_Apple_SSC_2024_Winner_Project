
import AVFoundation

// Class to Handle the Speech Synthesis
class SpeakerManager: NSObject, ObservableObject, AVSpeechSynthesizerDelegate{
    
    @Published var modesViewModel = ModesViewModel()
    @Published var isSpeaking = false
    
    var synthesizer = AVSpeechSynthesizer()
    
    override init(){
        super.init()
        self.synthesizer.delegate = self
        self.isSpeaking = false
    }
    
    // Setting isSpeaking Variable to True When the Speaker is Speaking
    internal func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        self.isSpeaking = true
        print(isSpeaking)
    }
    
    // Setting isSpeaking Variable to False When the Speaker Finishes Speaking
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        isSpeaking = false
        print("finished utterance")
        
    }
    
    // Function to Synthesize Voice
    func speak(textToSpeak: String, modesViewModel: ModesViewModel, identifier: String){
        
        let utterance = AVSpeechUtterance(string: textToSpeak)
        utterance.voice = AVSpeechSynthesisVoice(identifier: identifier)
        utterance.rate = modesViewModel.speakingRate
        
        self.synthesizer.speak(utterance)
        
    }
    
    // Function to Stop the Speaker When the User Wants To
    func stopSpeaking() {
        self.synthesizer.stopSpeaking(at: .immediate)
    }
    
}
