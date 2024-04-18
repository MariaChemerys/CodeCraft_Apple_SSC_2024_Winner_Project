
import SwiftUI
import AVFoundation

struct ComicView: View {
    
    // Variables to Access Data from Classes
    @ObservedObject var modesViewModel: ModesViewModel = ModesViewModel()
    @ObservedObject var speaker = SpeakerManager()
    
    // Variable to Switch Between Views
    @Binding var currentGameState: GameState
    
    // Variable to Transfer ModesViewModel Data to Other Views
    @Binding var currentModesViewModelState: ModesViewModel
    
    // Variables to Change the State of the View
    @State var voiceoverON: Bool = false
    @State var settingsViewON: Bool = false
    
    var body: some View {
        
        ZStack{
            
            // Setting Background Color
            Rectangle()
                .foregroundColor(Color("floralWhite"))
                .ignoresSafeArea()
            
            // Displaying Comic Scenes Grids
            VStack {
                GeometryReader{
                    geometry in
                    
                    VStack(spacing: -1) {
                        
                        VStack {
                            HStack{
                                Spacer()
                                gridItem(maxWidth: geometry.size.width, 1)
                                gridItem(maxWidth: geometry.size.width, 2)
                                Spacer()
                            }
                            
                            
                            HStack{
                                Spacer()
                                gridItem(maxWidth: geometry.size.width, 3)
                                gridItem(maxWidth: geometry.size.width, 4)
                                Spacer()
                            }
                        }
                        
                        Spacer()
                        HStack {
                            
                            // Button to Open the Settings
                            CircularTransparentFillButton(
                                
                                circleColor: modesViewModel.highContrastModeON ? (settingsViewON ? Color("porcelainRose") : Color("regalBlue")) : (settingsViewON ? Color("creamyPeach") : Color("meadowBlossomBlue")),
                                
                                circleFrameWidth: geometry.size.width * 0.05,
                                symbolColor: Color("floralWhite"),
                                action: {
                                    self.settingsViewON = true
                                    SoundManager.instance.playSound(named: "click")
                                },
                                sfSymbolName: "gearshape",
                                sfSymbolFontSize: geometry.size.width * 0.035,
                                strokeWidth: geometry.size.width * 0.0025
                            )
                            .padding(.horizontal)
                            
                            Spacer()
                            
                                // Button to Get to the Next View
                                CircularTransparentFillButton(
                                    
                                    circleColor: modesViewModel.highContrastModeON ? Color("regalBlue") : Color("meadowBlossomBlue"),
                                    
                                    circleFrameWidth: geometry.size.width * 0.05,
                                    symbolColor: Color("floralWhite"),
                                    action: {
                                        
                                        withAnimation{
                                            self.currentGameState = .intro
                                        }
                                        self.currentModesViewModelState = modesViewModel
                                        speaker.stopSpeaking()
                                        SoundManager.instance.playSound(named: "click")
                                        softHaptic()
                                    },
                                    sfSymbolName: "arrowshape.right",
                                    sfSymbolFontSize: geometry.size.width * 0.035,
                                    strokeWidth: geometry.size.width * 0.0025
                                )
                            
                            Spacer()
                            
                            // Button to Enable/Disable the Voiceover Mode
                            CircularTransparentFillButton(
                                
                                circleColor: modesViewModel.highContrastModeON ? (speaker.isSpeaking ? Color("porcelainRose") : Color("regalBlue")) : (speaker.isSpeaking ? Color("creamyPeach") : Color("meadowBlossomBlue")),
                                
                                circleFrameWidth: geometry.size.width * 0.05,
                                symbolColor: Color("floralWhite"),
                                action: {
                                    
                                    if speaker.isSpeaking{
                                        voiceoverON = false
                                    }else{
                                        voiceoverON = true
                                    }
                                    
                                    if voiceoverON {
                                        
                                        for comicContentItem in TextBlocksContentViewModel.instance.comicContent{
                                            speaker.speak(
                                                textToSpeak: modesViewModel.isENG ? comicContentItem.contentENG : comicContentItem.contentUA,
                                                modesViewModel: modesViewModel,
                                                identifier: modesViewModel.isENG ? "com.apple.voice.compact.en-US.Samantha" : "com.apple.voice.compact.uk-UA.Lesya")
                                            
                                        }
                                        
                                    } else {
                                        // Voiceover is OFF, Stop Speaking
                                        speaker.stopSpeaking()
                                    }

                                },
                                sfSymbolName: "speaker.wave.2",
                                sfSymbolFontSize: geometry.size.width * 0.035,
                                strokeWidth: geometry.size.width * 0.0025
                            )
                            .padding(.horizontal)
                            
                            
                        }
                        Spacer()
                    }
                    
                    
                }
            }
           
            // Displaying the SettingsView When the User Taps on the Settings Button
            if settingsViewON {
                GeometryReader{
                    geometry in
                    
                    SettingsView(maxWidth: geometry.size.width, maxHeight: geometry.size.height, textBackgroundColor: modesViewModel.highContrastModeON ? Color("eyeball") : Color("floralWhite"), modesViewModel: modesViewModel)
                    CloseButton(maxWidth: geometry.size.width, modesViewModel: modesViewModel, action: {self.settingsViewON = false})
                        .position(x: geometry.size.width * 0.865, y: geometry.size.height * 0.25)
                }
            }
        }
    }
    
    
    // Grids With Comic Scenes Design
    func gridItem(maxWidth: CGFloat, _ index: UInt) -> some View {
        ZStack {
            Image(modesViewModel.highContrastModeON ? "comic scene \(index) HC" : "comic scene \(index)")
                .resizable()
                .aspectRatio(1.28, contentMode: .fit)
                .padding(.top)
                .padding(.horizontal)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 0.0045 * maxWidth)
                .background(
                    Rectangle()
                        .fill(modesViewModel.highContrastModeON ? Color("lightSteelBlue") : Color("lavender"))
                )
            
            GeometryReader {
                geometry in
                VStack {
                    CharacterSpeechTextBlock(content: modesViewModel.isENG ? TextBlocksContentViewModel.instance.comicContent[Int(index) - 1].contentENG : TextBlocksContentViewModel.instance.comicContent[Int(index) - 1].contentUA, fontSize: 0.011 * maxWidth, padding: 0.0023 * maxWidth, strokeWidth: 0.0023 * maxWidth, maxWidth: geometry.size.width)
                        .frame(width: geometry.size.width * 0.95)
                    
                    Spacer()
                }
                .padding(.leading, geometry.size.width * 0.025)
                .padding(.top, geometry.size.height * 0.04)
                .frame(height: geometry.size.height * 0.95)
            }
            .aspectRatio(1.28, contentMode: .fit)
        }
        .frame(maxWidth: maxWidth * 0.365)
        .onAppear{
            modesViewModel.highContrastModeON = currentModesViewModelState.highContrastModeON
            modesViewModel.isENG = currentModesViewModelState.isENG
            modesViewModel.speakingRate = currentModesViewModelState.speakingRate
        }

    }
}

#Preview {
    ComicView(currentGameState: .constant(.comic), currentModesViewModelState: .constant(ModesViewModel()))
}
