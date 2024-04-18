
import Foundation
import SwiftUI
import AVFoundation
import SpriteKit

// Variable to Access the TextBlocksContentViewModel
var textBlocksContentsViewModel = TextBlocksContentViewModel()

// White Textblock With Black Stroke for Characters' Speech
struct CharacterSpeechTextBlock: View {
    
    var content: String
    var fontSize: CGFloat
    var padding: CGFloat
    var strokeWidth: CGFloat
    var maxWidth: CGFloat
    
    var body: some View {
        ZStack{
            Text(content)
                .font(Font.custom("Menlo", size: fontSize))
                .background(
                    RoundedRectangle(cornerRadius: maxWidth * 0.026)
                        .foregroundColor(.white)
                        .padding(-padding)
                    // Stroke
                    .background(
                        RoundedRectangle(cornerRadius: maxWidth * 0.026)
                            .foregroundColor(.black)
                            .padding(-padding - strokeWidth)
                    )
                )
                .bold()
        }
        
        
    }
}

// Buttons

    // Circular Transparent Fill Buttons
struct CircularTransparentFillButton: View {
   
    var circleColor: Color
    var circleFrameWidth: CGFloat
    var symbolColor: Color
    var action: (() -> Void)? = nil
    var sfSymbolName: String
    var sfSymbolFontSize: CGFloat
    var strokeWidth: CGFloat
    
    var body: some View {
        
        Button(action: {
            action?()
        }) {
            ZStack {
                Circle()
                    .fill(circleColor)
                    .frame(width: circleFrameWidth)
                    .background(
                    Circle()
                        .foregroundColor(.black)
                        .padding(-strokeWidth)
                    )
                
                Image(systemName: sfSymbolName)
                    .foregroundColor(.black)
                    .font(.system(size: sfSymbolFontSize))
                    .background(
                        Image(systemName: "\(sfSymbolName).fill")
                            .foregroundColor(symbolColor)
                            .font(.system(size: sfSymbolFontSize))
                    )
            }
        }
    }
}

    // Button to Close Pop-Up Views
struct CloseButton: View {
    
    var maxWidth: CGFloat
    @ObservedObject var modesViewModel: ModesViewModel
    var action: (() -> Void)? = nil
    
    var body: some View {
        
        Button(action: {
            action?()
            SoundManager.instance.playSound(named: "click")
        }){
            Image(modesViewModel.highContrastModeON ? "close button HC" : "close button")
                .resizable()
                .frame(width: maxWidth * 0.059, height: maxWidth * 0.06)
        }
        
    }
}

    // Button to Invoke the Game Restart Alert
struct GameRestartAlertButton: View {
   
    var circleColor: Color
    var circleFrameWidth: CGFloat
    var action: (() -> Void)? = nil
    var symbolWidth: CGFloat
    var strokeWidth: CGFloat
    var modesViewModel: ModesViewModel
    
    var body: some View {
        
        Button(action: {
            action?()
        }) {
            ZStack {
                Circle()
                    .fill(circleColor)
                    .frame(width: circleFrameWidth)
                    .background(
                    Circle()
                        .foregroundColor(.black)
                        .padding(-strokeWidth)
                    )
                
                Image(modesViewModel.highContrastModeON ? "arrow counterclockwise HC" : "arrow counterclockwise")
                    .resizable()
                    .interpolation(/*@START_MENU_TOKEN@*/.high/*@END_MENU_TOKEN@*/)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: symbolWidth)
            }
        }
    }
}

    // Progress Bar to Track Player's Progress
struct ProgressBar: View {
    
    var maxWidth: CGFloat
    var maxHeight: CGFloat
    var value: CGFloat
    @ObservedObject var modesViewModel: ModesViewModel
    
    var body: some View {
        
        let strokeWidth = maxWidth * 0.0025
        
        GeometryReader { geometry in
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: maxWidth * 0.005)
                    .frame(height: maxHeight * 0.015)
                    .foregroundColor(modesViewModel.highContrastModeON ? Color("eyeball") : Color("floralWhite"))
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.black)
                            .padding(-strokeWidth)
                    )
                RoundedRectangle(cornerRadius: maxWidth * 0.005)
                    .frame(width: maxWidth * 0.268 * value, height: maxHeight * 0.015)
                    .foregroundColor(modesViewModel.highContrastModeON ? Color("porcelainRose") : Color("creamyPeach"))
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.black)
                            .padding(-strokeWidth)
                    )
            }
            
        }
        .frame(width: maxWidth * 0.268, height: maxHeight * 0.08)
    }
    
}

    // Control Screen Circlepath Button
struct CirclepathButton: View {
   
    var circleColor: Color
    var circleFrameWidth: CGFloat
    var action: (() -> Void)? = nil
    var symbolWidth: CGFloat
    var strokeWidth: CGFloat
    var modesViewModel: ModesViewModel
    
    var body: some View {
        
        Button(action: {
            action?()
        }) {
            ZStack {
                Circle()
                    .fill(circleColor)
                    .frame(width: circleFrameWidth)
                    .background(
                    Circle()
                        .foregroundColor(.black)
                        .padding(-strokeWidth)
                    )
                
                Image(modesViewModel.highContrastModeON ? "circlepath icon HC" : "circlepath icon")
                    .resizable()
                    .interpolation(/*@START_MENU_TOKEN@*/.high/*@END_MENU_TOKEN@*/)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: symbolWidth)
            }
        }
    }
}

    // Button to Restart the Game
struct CheckmarkButton: View {
    
    var maxWidth: CGFloat
    
    @ObservedObject var modesViewModel: ModesViewModel
    var action: (() -> Void)? = nil
    
    var body: some View {
        
        Button(action: {
            action?()
            softHaptic()
            SoundManager.instance.playSound(named: "click")
        }){
            Image(modesViewModel.highContrastModeON ? "checkmark icon HC" : "checkmark icon")
                .resizable()
                .frame(width: maxWidth * 0.059, height: maxWidth * 0.06)
        }
        
    }
}

// Button to See a Photo of a Famous Programmer
struct ProgrammerPhotoButton: View {
    
    var circleColor: Color
    var circleFrameWidth: CGFloat
    var action: (() -> Void)? = nil
    var symbolWidth: CGFloat
    var strokeWidth: CGFloat
    var modesViewModel: ModesViewModel
    
    var body: some View {
        
        Button(action: {
            action?()
        }) {
            ZStack {
                Circle()
                    .fill(circleColor)
                    .frame(width: circleFrameWidth)
                    .background(
                        Circle()
                            .foregroundColor(.black)
                            .padding(-strokeWidth)
                    )
                
                Image(modesViewModel.highContrastModeON ? "picture button icon HC" : "picture button icon")
                    .resizable()
                    .interpolation(/*@START_MENU_TOKEN@*/.high/*@END_MENU_TOKEN@*/)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: symbolWidth)
            }
        }
    }
}

// Button to Read about the Contribution of a Famous Programmer
struct ProgrammerContributionButton: View {
    
    var circleColor: Color
    var circleFrameWidth: CGFloat
    var action: (() -> Void)? = nil
    var symbolWidth: CGFloat
    var strokeWidth: CGFloat
    var modesViewModel: ModesViewModel
    
    var body: some View {
        
        Button(action: {
            action?()
        }) {
            ZStack {
                Circle()
                    .fill(circleColor)
                    .frame(width: circleFrameWidth)
                    .background(
                        Circle()
                            .foregroundColor(.black)
                            .padding(-strokeWidth)
                    )
                
                Image(modesViewModel.highContrastModeON ? "info icon HC" : "info icon")
                    .resizable()
                    .interpolation(/*@START_MENU_TOKEN@*/.high/*@END_MENU_TOKEN@*/)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: symbolWidth)
            }
        }
    }
}

// Voiceover Sign
struct VoiceoverSign: View {
   
    var symbolColor: Color
    var sfSymbolFontSize: CGFloat
    
    var body: some View {
        
        ZStack {
            
            Image(systemName: "speaker.wave.2.fill")
                .foregroundColor(symbolColor)
                .font(.system(size: sfSymbolFontSize))
                .opacity(0.6)
                
        }
    }
}
