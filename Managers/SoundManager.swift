
import AVKit

class SoundManager{
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    // Function that Plays a Sound
    func playSound(named: String){
        
        guard let url = Bundle.main.url(forResource: named, withExtension: ".mp3") else {return}
        
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error{
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}
