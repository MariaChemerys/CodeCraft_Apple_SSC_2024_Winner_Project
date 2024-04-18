
import SwiftUI

struct IntroView: View {
    
    // Variable to Access Data from Other Classes
    @ObservedObject var modesViewModel: ModesViewModel = ModesViewModel()
    @ObservedObject var speaker = SpeakerManager()
    
    // Variable to Switch Between Views
    @Binding var currentGameState: GameState
    
    // Variable to Transfer ModesViewModel Data to Other Views
    @Binding var currentModesViewModelState: ModesViewModel
    
    // Variables to Change the State of the View
    @State var voiceoverON: Bool = false
    @State var secondPart: Bool = false
    @State var forwardButtonPressCounter = 0
    @State var settingsViewON: Bool = false
    @State var offsetY1: CGFloat = -30.0
    @State var offsetY2: CGFloat = 30.0
    
    var body: some View {
        
        ZStack{
            GeometryReader {
                geometry in
                
                HStack {
                    
                    // Button to Open the Settings
                    CircularTransparentFillButton(
                        
                        circleColor: modesViewModel.highContrastModeON ? (settingsViewON ? Color("porcelainRose") : Color("eyeball")) : (settingsViewON ? Color("creamyPeach") : Color("floralWhite")),
                        
                        circleFrameWidth: geometry.size.width * 0.05,
                        symbolColor: modesViewModel.highContrastModeON ? Color("regalBlue") : Color("honestBlue"),
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
                    
                    // Button to Return to the Last View
                    CircularTransparentFillButton(
                        
                        circleColor: modesViewModel.highContrastModeON ? Color("eyeball") :  Color("floralWhite"),
                        
                        circleFrameWidth: geometry.size.width * 0.05,
                        symbolColor: modesViewModel.highContrastModeON ? Color("regalBlue") : Color("honestBlue"),
                        action: {
                            
                            speaker.stopSpeaking()
                            forwardButtonPressCounter -= 1
                            
                            if forwardButtonPressCounter == 0{
                                withAnimation(.spring()){
                                    secondPart = false
                                }
                            }
                            else if forwardButtonPressCounter == (-1){
                                withAnimation{
                                    self.currentGameState = .comic
                                }
                                self.currentModesViewModelState = modesViewModel
                                softHaptic()
                            }
                            SoundManager.instance.playSound(named: "click")
                        },
                        sfSymbolName: "arrowshape.left",
                        sfSymbolFontSize: geometry.size.width * 0.035,
                        strokeWidth: geometry.size.width * 0.0025
                    )
                    .padding(.horizontal)
                    
                    // Button to Get to the Next View
                    CircularTransparentFillButton(
                        
                        circleColor: modesViewModel.highContrastModeON ? Color("eyeball") :  Color("floralWhite"),
                        
                        circleFrameWidth: geometry.size.width * 0.05,
                        symbolColor: modesViewModel.highContrastModeON ? Color("regalBlue") : Color("honestBlue"),
                        action: {
                            
                            speaker.stopSpeaking()
                            forwardButtonPressCounter += 1
                            
                            if forwardButtonPressCounter == 1{
                                withAnimation(.spring()){
                                    secondPart = true
                                }
                            }
                            else if forwardButtonPressCounter == 2{
                                withAnimation{
                                    self.currentGameState = .variables
                                }
                                self.currentModesViewModelState = modesViewModel
                                softHaptic()
                            }
                            SoundManager.instance.playSound(named: "click")
                        },
                        sfSymbolName: "arrowshape.right",
                        sfSymbolFontSize: geometry.size.width * 0.035,
                        strokeWidth: geometry.size.width * 0.0025
                    )
                    
                    
                    Spacer()
                    
                    // Button to Enable/Disable the Voiceover Mode
                    CircularTransparentFillButton(
                        
                        circleColor: modesViewModel.highContrastModeON ? (speaker.isSpeaking ? Color("porcelainRose") : Color("eyeball")) : (speaker.isSpeaking ? Color("creamyPeach") : Color("floralWhite")),
                        
                        circleFrameWidth: geometry.size.width * 0.05,
                        symbolColor: modesViewModel.highContrastModeON ? Color("regalBlue") : Color("honestBlue"),
                        action: {
                            
                            if speaker.isSpeaking{
                                voiceoverON = false
                            }else{
                                voiceoverON = true
                            }
                            
                            if voiceoverON {
                                
                                if !secondPart{
                                    speaker.speak(textToSpeak: modesViewModel.isENG ? TextBlocksContentViewModel.instance.introContent[0].contentENG : TextBlocksContentViewModel.instance.introContent[0].contentUA, modesViewModel: modesViewModel, identifier: modesViewModel.isENG ? "com.apple.voice.compact.en-US.Samantha" : "com.apple.voice.compact.uk-UA.Lesya")
                                }
                                else{
                                    speaker.speak(textToSpeak: modesViewModel.isENG ? TextBlocksContentViewModel.instance.introContent[1].contentENG : TextBlocksContentViewModel.instance.introContent[1].contentUA, modesViewModel: modesViewModel, identifier: modesViewModel.isENG ? "com.apple.voice.compact.en-US.Samantha" : "com.apple.voice.compact.uk-UA.Lesya")
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
                .padding(.top, geometry.size.height * 0.905)
                .zIndex(1)
                
                VStack(spacing: 0) {
                    Rectangle()
                        .foregroundColor(modesViewModel.highContrastModeON ? Color("tropicalPool"): Color("meadowBlossomBlue"))
                        .ignoresSafeArea()
                    VStack(spacing: 0) {
                        Rectangle()
                            .frame(height: geometry.size.height * 0.003)
                        ZStack {
                            Rectangle()
                                .foregroundColor(modesViewModel.highContrastModeON ? Color("regalBlue") : Color("honestBlue"))
                                .ignoresSafeArea()
                            .frame(height: geometry.size.height * 0.15)
                        }
                        
                    }
                }
                
                HStack {
                    Image(modesViewModel.highContrastModeON ? "IntroView background HC" : "IntroView background")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: geometry.size.height * 0.9)
                        .position(x: geometry.size.width * 0.15, y: geometry.size.height * 0.4)
                        .padding(.horizontal, -geometry.size.width * 0.004)
                }
                
                HStack {
                    Spacer()
                    
                    VStack(spacing: -geometry.size.height * 0.03) {
                        ProgressBar(maxWidth: geometry.size.width, maxHeight: geometry.size.height, value: secondPart ? 2/9 : 1/9, modesViewModel: modesViewModel)
                        
                        CharacterSpeechTextBlock(
                            content: secondPart ? (modesViewModel.isENG ? TextBlocksContentViewModel.instance.introContent[1].contentENG : TextBlocksContentViewModel.instance.introContent[1].contentUA) : (modesViewModel.isENG ? TextBlocksContentViewModel.instance.introContent[0].contentENG : TextBlocksContentViewModel.instance.introContent[0].contentUA),
                            fontSize: geometry.size.width * 0.021,
                            padding: geometry.size.width * 0.008,
                            strokeWidth: geometry.size.width * 0.0025,
                            maxWidth: geometry.size.width)
                        .frame(width: geometry.size.width * 0.954)
                        
                    }.padding(.top)
                    
                    Spacer()
                }
                
                
                Image(modesViewModel.highContrastModeON ? "Ada HC" : "Ada")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: geometry.size.height * 0.8)
                    .position(x: geometry.size.width * 0.23, y: geometry.size.height * 0.62)
                
                ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color("regalBlue"))
                    .frame(width: geometry.size.width * 0.55, height: geometry.size.height * 0.5)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.black)
                            .padding(-3)
                    )
                
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(modesViewModel.highContrastModeON ? Color("eyeball") : Color("floralWhite"))
                        .frame(width: geometry.size.width * 0.52, height: geometry.size.height * 0.46)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.black)
                                .padding(-3)
                        )
                    
                    if !secondPart{
                        VStack(spacing: geometry.size.height * 0.04) {
                            HStack(spacing: geometry.size.width * 0.04){

                                Image(modesViewModel.highContrastModeON ? "dandelion number grid HC" : "dandelion number grid")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: geometry.size.height * 0.294)
                                
                                if modesViewModel.highContrastModeON{
                                    AnimationView(scene: DandelionHCScene())
                                            .allowsHitTesting(false)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: geometry.size.height * 0.294)
                                }
                                else{
                                    AnimationView(scene: DandelionScene())
                                            .allowsHitTesting(false)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: geometry.size.height * 0.294)
                                }
                                
                                
                            }
                            
                            Image(modesViewModel.highContrastModeON ? "dandelion key HC" : "dandelion key")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: geometry.size.height * 0.042)

                        }.onAppear{
                            if offsetY1 != (-30){
                                offsetY1 = (-30)
                                offsetY2 = 30
                            }
                        }
                    }
                    else{
                        VStack{
                            Text(modesViewModel.isENG ? TextBlocksContentViewModel.instance.introContent[2].contentENG : TextBlocksContentViewModel.instance.introContent[2].contentUA)
                                .font(Font.custom("Menlo", size: geometry.size.width * 0.03))
                                .bold()
                                .padding(.top, geometry.size.height * 0.06)
                            
                            Spacer()
                            
                            HStack{
                                
                                Image(modesViewModel.highContrastModeON ? "number variable HC" : "number variable")
                                    .resizable()
                                    .interpolation(.high)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width * 0.1)
                                    .offset(y: offsetY1)
                                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: offsetY1)
                                    .onAppear {
                                        withAnimation {
                                            self.offsetY1 = geometry.size.height * 0.02
                                        }
                                    }
                                
                                Image(modesViewModel.highContrastModeON ? "arrayOfNumbers HC" : "arrayOfNumbers")
                                    .resizable()
                                    .interpolation(.high)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width * 0.16)
                                    .offset(y: offsetY2)
                                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: offsetY2)
                                    .onAppear {
                                        withAnimation {
                                            self.offsetY2 = -geometry.size.height * 0.02
                                        }
                                    }
                                
                                
                                Image(modesViewModel.highContrastModeON ? "loop HC" : "loop")
                                    .resizable()
                                    .interpolation(.high)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width * 0.1)
                                    .offset(y: offsetY1)
                                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: offsetY1)
                                    .onAppear {
                                        withAnimation {
                                            self.offsetY1 = geometry.size.height * 0.02
                                        }
                                    }
                                
                                
                                Image(modesViewModel.highContrastModeON ? "fileToArray() SpirA HC" : "fileToArray() SpirA")
                                    .resizable()
                                    .interpolation(.high)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width * 0.1)
                                    .offset(y: offsetY2)
                                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: offsetY2)
                                    .onAppear {
                                        withAnimation {
                                            self.offsetY2 = -geometry.size.height * 0.02
                                        }
                                        
                                    }
                                    
                                   
                            }  
                            
                            Spacer()
                            
                            HStack(spacing: geometry.size.width * 0.04){
                                ForEach(TextBlocksContentViewModel.instance.introContent.suffix(4)){
                                    contentItem in
                                    Text(modesViewModel.isENG ? contentItem.contentENG : contentItem.contentUA)
                                        .font(Font.custom("Menlo", size: geometry.size.width * 0.022))
                                        .bold()
                                }
                            }
                            .padding(.bottom, geometry.size.height * 0.05)
                        }
                    }
                    
                }
                .position(x: geometry.size.width * 0.65, y: geometry.size.height * 0.53)
                .frame(width: geometry.size.width * 0.55, height: geometry.size.height * 0.5)
                
                VoiceoverSign(
                    symbolColor: modesViewModel.highContrastModeON ? Color("regalBlue"): Color.white,
                    sfSymbolFontSize: geometry.size.width  * 0.02)
                .position(x: geometry.size.width * 0.968, y: geometry.size.height * 0.028)
            }
            
            if settingsViewON {
                GeometryReader{
                    geometry in
                    
                    SettingsView(maxWidth: geometry.size.width, maxHeight: geometry.size.height, textBackgroundColor: modesViewModel.highContrastModeON ? Color("eyeball") : Color("floralWhite"), modesViewModel: modesViewModel)
                    CloseButton(maxWidth: geometry.size.width, modesViewModel: modesViewModel, action: {self.settingsViewON = false})
                        .position(x: geometry.size.width * 0.865, y: geometry.size.height * 0.25)
                }
            }
        }.onAppear{
            modesViewModel.highContrastModeON = currentModesViewModelState.highContrastModeON
            modesViewModel.isENG = currentModesViewModelState.isENG
            modesViewModel.speakingRate = currentModesViewModelState.speakingRate
        }
        
    }
}

#Preview {
    IntroView(currentGameState: .constant(.intro), currentModesViewModelState: .constant(ModesViewModel()))
}
