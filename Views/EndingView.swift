
import SwiftUI
import AVFoundation

struct EndingView: View {
    
    // Variables to Access Data from Classes
    @ObservedObject var modesViewModel: ModesViewModel = ModesViewModel()
    @ObservedObject var speaker = SpeakerManager()
    
    // Variable to Switch Between Views
    @Binding var currentGameState: GameState
    
    // Variable to Transfer ModesViewModel Data to Other Views
    @Binding var currentModesViewModelState: ModesViewModel
    
    // Variables to Change the State of the View
    @State var voiceoverON: Bool = false
    @State var forwardButtonPressCounter = 0
    @State var settingsViewON: Bool = false
    @State var restartGameAlertON: Bool = false
    @State var progressBarValue: Double = 1
    
    // Variables to Switch Between the Photo of the Famous Programmer and Their Achievements' Description on the Screen
    @State private var isMargaretHamiltonPhotoON: Bool = true
    @State private var isGraceHopperPhotoON: Bool = true
    @State private var isAlanTuringPhotoON: Bool = true
    
    var body: some View {
        
        ZStack{
            GeometryReader {
                geometry in
                
                HStack(spacing: geometry.size.width * 0.24) {
                    Rectangle()
                        .frame(width: geometry.size.width * 0.002, height: geometry.size.height * 0.023)
                    Rectangle()
                        .frame(width: geometry.size.width * 0.002, height: geometry.size.height * 0.023)
                    Rectangle()
                        .frame(width: geometry.size.width * 0.002, height: geometry.size.height * 0.023)
                }
                .position(x: geometry.size.width * 0.58, y: geometry.size.height * 0.34)
                
                ZStack {
                    Image(modesViewModel.highContrastModeON ? "Ada with laptop HC" : "Ada with laptop")
                        .resizable()
                        .interpolation(.high)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(height: geometry.size.height * 0.75)
                .position(x: geometry.size.width * 0.45, y: geometry.size.height * 0.64)
                
                VStack{
                    HStack(spacing: geometry.size.width * 0.03){
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color("regalBlue"))
                                .frame(width: geometry.size.width * 0.21, height: geometry.size.height * 0.49)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(.black)
                                        .padding(-geometry.size.width * 0.003)
                                )
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(modesViewModel.highContrastModeON ? Color("eyeball") : Color("floralWhite"))
                                    .frame(width: geometry.size.width * 0.19, height: geometry.size.height * 0.46)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .foregroundColor(.black)
                                            .padding(-geometry.size.width * 0.003)
                                    )
                                
                                VStack{
                                    VStack {
                                        ZStack {
                                            if isMargaretHamiltonPhotoON{
                                                VStack{
                                                    
                                                    Image("Margaret Hamilton 58")
                                                        .resizable()
                                                        .interpolation(.high)
                                                        .aspectRatio(contentMode: .fit)
                                                    Text(modesViewModel.isENG ? TextBlocksContentViewModel.instance.endingContent[1].contentENG : TextBlocksContentViewModel.instance.endingContent[1].contentUA)
                                                        .font(Font.custom("Menlo", size: geometry.size.width * 0.016))
                                                        .bold()
                                                    
                                                }
                                                .frame(width: geometry.size.width * 0.18)
                                                .padding(.top, geometry.size.height * 0.023)
                                            }
                                            else{
                                                VStack(spacing: 0){
                                                    
                                                    Text(modesViewModel.isENG ? TextBlocksContentViewModel.instance.endingContent[4].contentENG : TextBlocksContentViewModel.instance.endingContent[4].contentUA)
                                                        .font(Font.custom("Menlo", size: geometry.size.height * 0.023))
                                                        .bold()
                                                        .padding(.leading, geometry.size.width * 0.004)
                                                    
                                                }
                                                .frame(width: geometry.size.width * 0.195, height : geometry.size.height * 0.45)
                                                .padding(.top, geometry.size.height * 0.001)
                                                
                                            }
                                        }
                                    }
                                    .frame(height: geometry.size.height * 0.36)
                                    
                                    
                                    
                                    HStack{
                                        ProgrammerPhotoButton(
                                            circleColor: isMargaretHamiltonPhotoON ? (modesViewModel.highContrastModeON ? Color("porcelainRose") : Color("creamyPeach")) : (modesViewModel.highContrastModeON ? Color("regalBlue") : Color("honestBlue")),
                                            circleFrameWidth: geometry.size.width * 0.05,
                                            action: {
                                                if !isMargaretHamiltonPhotoON{
                                                    withAnimation{
                                                        self.isMargaretHamiltonPhotoON = true
                                                    }
                                                    SoundManager.instance.playSound(named: "click")
                                                }
                                            },
                                            symbolWidth: geometry.size.width * 0.036,
                                            strokeWidth: geometry.size.width * 0.0025,
                                            modesViewModel: modesViewModel
                                        )
                                        .padding(.horizontal, geometry.size.width * 0.005)
                                        
                                        ProgrammerContributionButton(
                                            circleColor: !isMargaretHamiltonPhotoON ? (modesViewModel.highContrastModeON ? Color("porcelainRose") : Color("creamyPeach")) : (modesViewModel.highContrastModeON ? Color("regalBlue") : Color("honestBlue")),
                                            circleFrameWidth: geometry.size.width * 0.05,
                                            action: {
                                                if isMargaretHamiltonPhotoON{
                                                    withAnimation{
                                                        self.isMargaretHamiltonPhotoON = false
                                                    }
                                                    SoundManager.instance.playSound(named: "click")
                                                }
                                            },
                                            symbolWidth: geometry.size.width * 0.021,
                                            strokeWidth: geometry.size.width * 0.0025,
                                            modesViewModel: modesViewModel
                                        )
                                        .padding(.horizontal, geometry.size.width * 0.005)
                                    }
                                    .padding(.bottom, geometry.size.height * 0.025)
                                    
                                }
                            }
                            
                        }
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color("regalBlue"))
                                .frame(width: geometry.size.width * 0.21, height: geometry.size.height * 0.49)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(.black)
                                        .padding(-geometry.size.width * 0.003)
                                )
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(modesViewModel.highContrastModeON ? Color("eyeball") : Color("floralWhite"))
                                    .frame(width: geometry.size.width * 0.19, height: geometry.size.height * 0.46)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .foregroundColor(.black)
                                            .padding(-geometry.size.width * 0.003)
                                    )
                                VStack{
                                    VStack {
                                        ZStack {
                                            if isAlanTuringPhotoON{
                                                VStack{
                                                    
                                                    Image("Alan Turing")
                                                        .resizable()
                                                        .interpolation(.high)
                                                        .aspectRatio(contentMode: .fit)
                                                    Text(modesViewModel.isENG ? TextBlocksContentViewModel.instance.endingContent[2].contentENG : TextBlocksContentViewModel.instance.endingContent[2].contentUA)
                                                        .font(Font.custom("Menlo", size: geometry.size.width * 0.016))
                                                        .bold()
                                                    
                                                }
                                                .frame(width: geometry.size.width * 0.18)
                                                .padding(.top, geometry.size.height * 0.023)
                                            }
                                            else{
                                                VStack(spacing: 0){
                                                    
                                                    Text(modesViewModel.isENG ? TextBlocksContentViewModel.instance.endingContent[5].contentENG : TextBlocksContentViewModel.instance.endingContent[5].contentUA)
                                                        .font(Font.custom("Menlo", size: modesViewModel.isENG ? geometry.size.height * 0.023 : geometry.size.height * 0.022))
                                                        .bold()
                                                        .padding(.leading, geometry.size.width * 0.001)

                                                }
                                                .frame(width: geometry.size.width * 0.195, height : geometry.size.height * 0.45)
                                                .padding(.top, geometry.size.height * 0.001)
                                                .padding(.leading, geometry.size.height * 0.01)
                                                
                                            }
                                        }
                                    }
                                    .frame(height: geometry.size.height * 0.36)
                                    
                                    
                                    
                                    HStack{
                                        ProgrammerPhotoButton(
                                            circleColor: isAlanTuringPhotoON ? (modesViewModel.highContrastModeON ? Color("porcelainRose") : Color("creamyPeach")) : (modesViewModel.highContrastModeON ? Color("regalBlue") : Color("honestBlue")),
                                            circleFrameWidth: geometry.size.width * 0.05,
                                            action: {
                                                if !isAlanTuringPhotoON{
                                                    withAnimation{
                                                        self.isAlanTuringPhotoON = true
                                                    }
                                                    SoundManager.instance.playSound(named: "click")
                                                }
                                            },
                                            symbolWidth: geometry.size.width * 0.036,
                                            strokeWidth: geometry.size.width * 0.0025,
                                            modesViewModel: modesViewModel
                                        )
                                        .padding(.horizontal, geometry.size.width * 0.005)
                                        
                                        ProgrammerContributionButton(
                                            circleColor: !isAlanTuringPhotoON ? (modesViewModel.highContrastModeON ? Color("porcelainRose") : Color("creamyPeach")) : (modesViewModel.highContrastModeON ? Color("regalBlue") : Color("honestBlue")),
                                            circleFrameWidth: geometry.size.width * 0.05,
                                            action: {
                                                if isAlanTuringPhotoON{
                                                    withAnimation{
                                                        self.isAlanTuringPhotoON = false
                                                    }
                                                    SoundManager.instance.playSound(named: "click")
                                                }
                                            },
                                            symbolWidth: geometry.size.width * 0.021,
                                            strokeWidth: geometry.size.width * 0.0025,
                                            modesViewModel: modesViewModel
                                        )
                                        .padding(.horizontal, geometry.size.width * 0.005)
                                    }
                                    .padding(.bottom, geometry.size.height * 0.025)
                                    
                                }
                            }
                            
                        }
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color("regalBlue"))
                                .frame(width: geometry.size.width * 0.21, height: geometry.size.height * 0.49)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(.black)
                                        .padding(-geometry.size.width * 0.003)
                                )
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(modesViewModel.highContrastModeON ? Color("eyeball") : Color("floralWhite"))
                                    .frame(width: geometry.size.width * 0.19, height: geometry.size.height * 0.46)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .foregroundColor(.black)
                                            .padding(-geometry.size.width * 0.003)
                                    )
                                VStack{
                                    VStack {
                                        ZStack {
                                            if isGraceHopperPhotoON{
                                                VStack{
                                                    
                                                    Image("Grace Hopper")
                                                        .resizable()
                                                        .interpolation(.high)
                                                        .aspectRatio(contentMode: .fit)
                                                    Text(modesViewModel.isENG ? TextBlocksContentViewModel.instance.endingContent[3].contentENG : TextBlocksContentViewModel.instance.endingContent[3].contentUA)
                                                        .font(Font.custom("Menlo", size: geometry.size.width * 0.016))
                                                        .bold()
                                                    
                                                }
                                                .frame(width: geometry.size.width * 0.18)
                                                .padding(.top, geometry.size.height * 0.023)
                                            }
                                            else{
                                                VStack(spacing: 0){
                                                    
                                                    Text(modesViewModel.isENG ? TextBlocksContentViewModel.instance.endingContent[6].contentENG : TextBlocksContentViewModel.instance.endingContent[6].contentUA)
                                                        .font(Font.custom("Menlo", size: geometry.size.height * 0.023))
                                                        .bold()
                                                        .padding(.leading, geometry.size.width * 0.001)
                                                    
                                                }
                                                .frame(width: geometry.size.width * 0.195, height : geometry.size.height * 0.45)
                                                .padding(.top, geometry.size.height * 0.001)
                                                .padding(.leading, geometry.size.height * 0.01)
                                                
                                            }
                                        }
                                    }
                                    .frame(height: geometry.size.height * 0.36)
                                    
                                    
                                    
                                    HStack{
                                        ProgrammerPhotoButton(
                                            circleColor: isGraceHopperPhotoON ? (modesViewModel.highContrastModeON ? Color("porcelainRose") : Color("creamyPeach")) : (modesViewModel.highContrastModeON ? Color("regalBlue") : Color("honestBlue")),
                                            circleFrameWidth: geometry.size.width * 0.05,
                                            action: {
                                                if !isGraceHopperPhotoON {
                                                    withAnimation{
                                                        self.isGraceHopperPhotoON = true
                                                    }
                                                    SoundManager.instance.playSound(named: "click")
                                                }
                                            },
                                            symbolWidth: geometry.size.width * 0.036,
                                            strokeWidth: geometry.size.width * 0.0025,
                                            modesViewModel: modesViewModel
                                        )
                                        .padding(.horizontal, geometry.size.width * 0.005)
                                        
                                        ProgrammerContributionButton(
                                            circleColor: !isGraceHopperPhotoON ? (modesViewModel.highContrastModeON ? Color("porcelainRose") : Color("creamyPeach")) : (modesViewModel.highContrastModeON ? Color("regalBlue") : Color("honestBlue")),
                                            circleFrameWidth: geometry.size.width * 0.05,
                                            action: {
                                                if isGraceHopperPhotoON{
                                                    withAnimation{
                                                        self.isGraceHopperPhotoON = false
                                                    }
                                                    SoundManager.instance.playSound(named: "click")
                                                }
                                            },
                                            symbolWidth: geometry.size.width * 0.021,
                                            strokeWidth: geometry.size.width * 0.0025,
                                            modesViewModel: modesViewModel
                                        )
                                        .padding(.horizontal, geometry.size.width * 0.005)
                                    }
                                    .padding(.bottom, geometry.size.height * 0.025)
                                    
                                }
                            }
                            
                        }
                    }
                    .position(x: geometry.size.width * 0.58, y: geometry.size.height * 0.595)
                    
                    HStack (spacing: geometry.size.width * 0.215){
                        VoiceoverSign(
                            symbolColor: Color.white,
                            sfSymbolFontSize: geometry.size.width  * 0.02)
                        .opacity(isMargaretHamiltonPhotoON ? 0.0 : 1.0)
                        
                        VoiceoverSign(
                            symbolColor: Color.white,
                            sfSymbolFontSize: geometry.size.width  * 0.02)
                        .opacity(isAlanTuringPhotoON ? 0.0 : 1.0)
                        
                        VoiceoverSign(
                            symbolColor: Color.white,
                            sfSymbolFontSize: geometry.size.width  * 0.02)
                        .opacity(isGraceHopperPhotoON ? 0.0 : 1.0)
                    }
                    .position(x: geometry.size.width * 0.675, y: geometry.size.height * 0.365)
                }
                
                VoiceoverSign(
                    symbolColor: modesViewModel.highContrastModeON ? Color("regalBlue"): Color.white,
                    sfSymbolFontSize: geometry.size.width  * 0.02)
                .position(x: geometry.size.width * 0.968, y: geometry.size.height * 0.028)
                .opacity(!isMargaretHamiltonPhotoON || !isAlanTuringPhotoON || !isGraceHopperPhotoON ? 0.0 : 1.0)
                
                
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
                        
                        circleColor: modesViewModel.highContrastModeON ? Color("eyeball") : Color("floralWhite"),
                        circleFrameWidth: geometry.size.width * 0.05,
                        symbolColor: modesViewModel.highContrastModeON ? Color("regalBlue") : Color("honestBlue"),
                        action: {
                            speaker.stopSpeaking()
                            withAnimation{
                                self.currentGameState = .functions
                            }
                            self.currentModesViewModelState = modesViewModel
                            
                            softHaptic()
                            SoundManager.instance.playSound(named: "click")
                        },
                        
                        sfSymbolName: "arrowshape.left",
                        sfSymbolFontSize: geometry.size.width * 0.035,
                        strokeWidth: geometry.size.width * 0.0025
                    )
                    .padding(.horizontal)
                    
                    // Button to Get to the First View
                    GameRestartAlertButton(
                        circleColor: restartGameAlertON ? (modesViewModel.highContrastModeON ? Color("porcelainRose") : Color("creamyPeach")) : (modesViewModel.highContrastModeON ? Color("eyeball") : Color("floralWhite")),
                        circleFrameWidth: geometry.size.width * 0.05,
                        action: {
                            self.restartGameAlertON = true
                            SoundManager.instance.playSound(named: "click")
                        },
                        symbolWidth: geometry.size.width * 0.032,
                        strokeWidth: geometry.size.width * 0.0025,
                        modesViewModel: modesViewModel
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
                                
                                if isMargaretHamiltonPhotoON && isAlanTuringPhotoON && isGraceHopperPhotoON {
                                    speaker.speak(textToSpeak: modesViewModel.isENG ? TextBlocksContentViewModel.instance.endingContent[0].contentENG : TextBlocksContentViewModel.instance.endingContent[0].contentUA, modesViewModel: modesViewModel, identifier: modesViewModel.isENG ? "com.apple.voice.compact.en-US.Samantha" : "com.apple.voice.compact.uk-UA.Lesya")
                                }
                                
                                if !isMargaretHamiltonPhotoON{
                                    speaker.speak(textToSpeak: modesViewModel.isENG ? TextBlocksContentViewModel.instance.endingContent[4].contentENG : TextBlocksContentViewModel.instance.endingContent[4].contentUA, modesViewModel: modesViewModel, identifier: modesViewModel.isENG ? "com.apple.voice.compact.en-US.Samantha" : "com.apple.voice.compact.uk-UA.Lesya")
                                }
                                
                                if !isAlanTuringPhotoON{
                                    speaker.speak(textToSpeak: modesViewModel.isENG ? TextBlocksContentViewModel.instance.endingContent[5].contentENG : TextBlocksContentViewModel.instance.endingContent[5].contentUA, modesViewModel: modesViewModel, identifier: modesViewModel.isENG ? "com.apple.voice.compact.en-US.Samantha" : "com.apple.voice.compact.uk-UA.Lesya")
                                }
                                
                                if !isGraceHopperPhotoON{
                                    speaker.speak(textToSpeak: modesViewModel.isENG ? TextBlocksContentViewModel.instance.endingContent[6].contentENG : TextBlocksContentViewModel.instance.endingContent[6].contentUA, modesViewModel: modesViewModel, identifier: modesViewModel.isENG ? "com.apple.voice.compact.en-US.Samantha" : "com.apple.voice.compact.uk-UA.Lesya")
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
                    
                }.padding(.top, geometry.size.height * 0.905)
                
                if settingsViewON {
                    
                    SettingsView(maxWidth: geometry.size.width, maxHeight: geometry.size.height, textBackgroundColor: modesViewModel.highContrastModeON ? Color("eyeball") : Color("floralWhite"), modesViewModel: modesViewModel)
                    CloseButton(maxWidth: geometry.size.width, modesViewModel: modesViewModel, action: {self.settingsViewON = false})
                        .position(x: geometry.size.width * 0.865, y: geometry.size.height * 0.25)
                    
                }
                
                if restartGameAlertON{
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color("lowOpacityWhite"))
                            .ignoresSafeArea()
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color("regalBlue"))
                            .frame(width: geometry.size.width * 0.65, height: geometry.size.height * 0.34)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(.black)
                                    .padding(-geometry.size.width * 0.003)
                            )
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(modesViewModel.highContrastModeON ? Color("eyeball") : Color("floralWhite"))
                                .frame(width: geometry.size.width * 0.62, height: geometry.size.height * 0.3)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(.black)
                                        .padding(-geometry.size.width * 0.003)
                                )
                            
                            VStack{
                                Text(modesViewModel.isENG ? TextBlocksContentViewModel.instance.endingContent[7].contentENG : TextBlocksContentViewModel.instance.endingContent[7].contentUA)
                                    .font(Font.custom("Menlo", size: geometry.size.width * 0.03))
                                    .bold()
                                    .padding(.top, geometry.size.width * 0.01)
                                HStack{
                                    CloseButton(
                                        maxWidth: geometry.size.width,
                                        modesViewModel: modesViewModel,
                                        action: {
                                                self.restartGameAlertON = false
                                        })
                                    .padding(.horizontal)
                                    CheckmarkButton(
                                        maxWidth: geometry.size.width,
                                        modesViewModel: modesViewModel,
                                        action: {
                                            speaker.stopSpeaking()
                                            withAnimation{
                                                self.currentGameState = .comic
                                            }
                                            self.currentModesViewModelState = modesViewModel
                                        })
                                    .padding(.horizontal)
                                }
                                .padding(.top, geometry.size.height * 0.035)
                            }
                        }
                    }
                }
            }.zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            
            GeometryReader {
                geometry in
                
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
                    Spacer()
                    
                    VStack(spacing: -geometry.size.height * 0.03) {
                        ProgressBar(maxWidth: geometry.size.width, maxHeight: geometry.size.height, value: progressBarValue, modesViewModel: modesViewModel)
                        
                        CharacterSpeechTextBlock(
                            content: modesViewModel.isENG ? TextBlocksContentViewModel.instance.endingContent[0].contentENG : TextBlocksContentViewModel.instance.endingContent[0].contentUA,
                            fontSize: geometry.size.width * 0.021,
                            padding: geometry.size.width * 0.008,
                            strokeWidth: geometry.size.width * 0.0025,
                            maxWidth: geometry.size.width)
                        .frame(width: geometry.size.width * 0.954)
                        
                    }.padding(.top)
                    
                    Spacer()
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
    EndingView(currentGameState: .constant(.ending), currentModesViewModelState: .constant(ModesViewModel()))
}
