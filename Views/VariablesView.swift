
import SwiftUI
import AVFoundation


struct VariablesView: View {
    
    // Variables to Access Data from Classes
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
    @State var progressBarValue: Double = 3/9
    
    // Variables to Make the Characters and Items Fade In and Fade Out
    @State var areValuesSeen: Bool = false
    @State var leftVariableOpacity: Double = 0.0
    @State var rightVariableOpacity: Double = 0.0
    @State var numberVariableOpacity: Double = 0.0
    @State var filesOpacity: Double = 1.0
    
    // Variables to Make the Characters Move Away From the Screen
    @State private var greetingVariableOffset: CGSize = .zero
    @State private var starVariableOffset: CGSize = .zero
    
    // Variables to Make the Characters Move Into the Screen
    @State private var keyFileNameVariableOffset: CGSize = CGSize(width: -UIScreen.main.bounds.width, height: 0)
    @State private var gridFileNameVariableOffset: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 0)
    
    // Variables to Know Whether Animations are in Progress and Buttons to Go to the Next/Last Screen are Available
    @State private var isFirstPartAnimationInProgress: Bool = false
    @State private var isValuesAnimationFinished: Bool = false
    @State private var isSecondPartAnimationInProgress: Bool = false
    @State private var isSecondPartAnimationFinished: Bool = false
    
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
                        
                        circleColor: modesViewModel.highContrastModeON ? (isFirstPartAnimationInProgress || isSecondPartAnimationInProgress ? Color("pacificBliss") : Color("eyeball")) : (isFirstPartAnimationInProgress || isSecondPartAnimationInProgress ? Color("icy") : Color("floralWhite")),
                        
                        circleFrameWidth: geometry.size.width * 0.05,
                        symbolColor: modesViewModel.highContrastModeON ? Color("regalBlue") : Color("honestBlue"),
                        action: {
                            
                            if !isFirstPartAnimationInProgress && !isSecondPartAnimationInProgress {
                                
                                speaker.stopSpeaking()
                                forwardButtonPressCounter -= 1
                                
                                if forwardButtonPressCounter == 0{
                                    withAnimation(.spring()){
                                        secondPart = false
                                    }
                                    self.greetingVariableOffset = .zero
                                    self.starVariableOffset = .zero
                                    self.keyFileNameVariableOffset = CGSize(width: -UIScreen.main.bounds.width, height: 0)
                                    self.gridFileNameVariableOffset = CGSize(width: UIScreen.main.bounds.width, height: 0)
                                    self.isValuesAnimationFinished = false
                                    self.isSecondPartAnimationFinished = false
                                    self.filesOpacity = 1.0
                                    withAnimation{
                                        self.progressBarValue = 3/9
                                    }
                                }
                                else if forwardButtonPressCounter == (-1){
                                    withAnimation{
                                        self.currentGameState = .intro
                                    }
                                    self.currentModesViewModelState = modesViewModel
                                    softHaptic()
                                }
                                SoundManager.instance.playSound(named: "click")
                            }
                        },
                        sfSymbolName: "arrowshape.left",
                        sfSymbolFontSize: geometry.size.width * 0.035,
                        strokeWidth: geometry.size.width * 0.0025
                    )
                    .padding(.horizontal)
                    
                    // Button to Get to the Next View
                    CircularTransparentFillButton(
                        
                        circleColor: modesViewModel.highContrastModeON ? Color("pacificBliss") : Color("icy"),
                        
                        circleFrameWidth: geometry.size.width * 0.05,
                        symbolColor: modesViewModel.highContrastModeON ? Color("regalBlue") : Color("honestBlue"),
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
                                    speaker.speak(textToSpeak: modesViewModel.isENG ? TextBlocksContentViewModel.instance.variablesContent[0].contentENG : TextBlocksContentViewModel.instance.variablesContent[0].contentUA, modesViewModel: modesViewModel, identifier: modesViewModel.isENG ? "com.apple.voice.compact.en-US.Samantha" : "com.apple.voice.compact.uk-UA.Lesya")
                                }
                                else{
                                    speaker.speak(textToSpeak: modesViewModel.isENG ? TextBlocksContentViewModel.instance.variablesContent[1].contentENG : TextBlocksContentViewModel.instance.variablesContent[1].contentUA, modesViewModel: modesViewModel, identifier: modesViewModel.isENG ? "com.apple.voice.compact.en-US.Samantha" : "com.apple.voice.compact.uk-UA.Lesya")
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
                    Spacer()
                    
                    VStack(spacing: -geometry.size.height * 0.03) {
                        ProgressBar(maxWidth: geometry.size.width, maxHeight: geometry.size.height, value: progressBarValue, modesViewModel: modesViewModel)
                        
                        CharacterSpeechTextBlock(
                            content: secondPart ? (modesViewModel.isENG ? TextBlocksContentViewModel.instance.variablesContent[1].contentENG : TextBlocksContentViewModel.instance.variablesContent[1].contentUA) : (modesViewModel.isENG ? TextBlocksContentViewModel.instance.variablesContent[0].contentENG : TextBlocksContentViewModel.instance.variablesContent[0].contentUA),
                            fontSize: geometry.size.width * 0.021,
                            padding: geometry.size.width * 0.008,
                            strokeWidth: geometry.size.width * 0.0025,
                            maxWidth: geometry.size.width)
                        .frame(width: geometry.size.width * 0.954)
                        
                    }.padding(.top)
                    
                    Spacer()
                }
                
                // Control Screen
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color("regalBlue"))
                        .frame(width: geometry.size.width * 0.25, height: geometry.size.height * 0.5)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.black)
                                .padding(-geometry.size.width * 0.003)
                        )
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(modesViewModel.highContrastModeON ? Color("eyeball") : Color("floralWhite"))
                            .frame(width: geometry.size.width * 0.22, height: geometry.size.height * 0.46)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(.black)
                                    .padding(-geometry.size.width * 0.003)
                            )
                        VStack{
                            VStack {
                                if !secondPart || (secondPart && isSecondPartAnimationFinished){
                                    ZStack {
                                        VStack {
                                            VStack {
                                                Image(modesViewModel.highContrastModeON ? "picture icon HC" : "picture icon")
                                                    .resizable()
                                                    .interpolation(.high)
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(height: geometry.size.height * 0.105)
                                                
                                                
                                                Text("...")
                                                    .font(Font.custom("Menlo", size: geometry.size.width * 0.021))
                                                    .bold()
                                                    .padding(geometry.size.width * 0.005)
                                            }
                                            
                                              
                                            VStack {
                                                VStack {
                                                    Image(modesViewModel.highContrastModeON ? "picture icon HC" : "picture icon")
                                                        .resizable()
                                                        .interpolation(.high)
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(height: geometry.size.height * 0.105)
                                                    
                                                    
                                                    Text("...")
                                                        .font(Font.custom("Menlo", size: geometry.size.width * 0.021))
                                                        .bold()
                                                }

                                                Rectangle()
                                                    .frame(width: geometry.size.width * 0.22, height: geometry.size.height * 0.004)
                                            }

                                        }
                                        .padding(.top)
                                    }
                                    
                                    .padding(.bottom, geometry.size.height * 0.013)
                                }
                                else{
                                    ZStack {
                                        VStack {
                                            VStack {
                                                Image(modesViewModel.highContrastModeON ? "file icon HC" : "file icon")
                                                    .resizable()
                                                    .interpolation(.high)
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(height: geometry.size.height * 0.105)
                                                
                                                
                                                Text("key.txt")
                                                    .font(Font.custom("Menlo", size: geometry.size.width * 0.021))
                                                    .bold()
                                                    .padding(geometry.size.width * 0.005)
                                            }
                                            .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .foregroundColor(modesViewModel.highContrastModeON ? Color("kodamaWhite") : Color("ditheredSky"))
                                                .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .padding(-geometry.size.width * 0.002)
                                                )
                                                .frame(width: geometry.size.width * 0.15)
                                                
                                            )
                                            .opacity(filesOpacity)
                                              
                                            VStack {
                                                VStack {
                                                    Image(modesViewModel.highContrastModeON ? "file icon HC" : "file icon")
                                                        .resizable()
                                                        .interpolation(.high)
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(height: geometry.size.height * 0.105)
                                                    
                                                    
                                                    Text("grid.txt")
                                                        .font(Font.custom("Menlo", size: geometry.size.width * 0.021))
                                                        .bold()
                                                }
                                                .opacity(filesOpacity)

                                                Rectangle()
                                                    .frame(width: geometry.size.width * 0.22, height: geometry.size.height * 0.004)
                                            }
                                            .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .foregroundColor(modesViewModel.highContrastModeON ? Color("kodamaWhite") : Color("ditheredSky"))
                                                .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .padding(-geometry.size.width * 0.002)
                                                    .opacity(filesOpacity)
                                                )
                                                .padding(.bottom)
                                                .frame(width: geometry.size.width * 0.15)
                                                .opacity(filesOpacity)
                                            )
                                            
                                            
                                        }
                                        
                                        
                                        .padding(.top)
                                    }
                                    
                                    .padding(.bottom, geometry.size.height * 0.013)
                                }
                            }

                            .frame(height: geometry.size.height * 0.36)
                            
                            HStack{
                                CircularTransparentFillButton(
                                    
                                    circleColor: !isValuesAnimationFinished ? (modesViewModel.highContrastModeON ? (areValuesSeen ? Color("porcelainRose") : Color("regalBlue")) : (areValuesSeen ? Color("creamyPeach") : Color("honestBlue"))) : (modesViewModel.highContrastModeON ? Color("pacificBliss") : Color("icy")),
                                    circleFrameWidth: geometry.size.width * 0.05,
                                    symbolColor: modesViewModel.highContrastModeON ? Color("eyeball") : Color("floralWhite"),
                                    action: {
                                        if !secondPart && !isFirstPartAnimationInProgress {
                                            self.areValuesSeen = true
                                            self.isFirstPartAnimationInProgress = true
                                            SoundManager.instance.playSound(named: "click")
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                                                SoundManager.instance.playSound(named: "unlocking")
                                            }
                                            withAnimation(Animation.easeIn(duration: 1)) {
                                                // Set opacity to 1 to make the image fade in
                                                leftVariableOpacity = 1.0
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                                                    SoundManager.instance.playSound(named: "unlocking")
                                                }
                                                
                                                withAnimation(Animation.easeOut(duration: 1)) {
                                                    // Set opacity to 0 to make the image fade out
                                                    leftVariableOpacity = 0.0
                                                }
                                                
                                                withAnimation(Animation.easeIn(duration: 1)) {
                                                    numberVariableOpacity = 1.0
                                                }
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                                                    
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                                                        SoundManager.instance.playSound(named: "unlocking")
                                                    }
                                                    
                                                    withAnimation(Animation.easeOut(duration: 1)) {
                                                        // Set opacity to 0 to make the image fade out
                                                        numberVariableOpacity = 0.0
                                                    }
                                                    
                                                    withAnimation(Animation.easeIn(duration: 1)) {
                                                        rightVariableOpacity = 1.0
                                                    }
                                                    
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                                                        withAnimation(Animation.easeOut(duration: 1)) {
                                                            rightVariableOpacity = 0.0
                                                        }
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                                            self.areValuesSeen = false
                                                            self.isValuesAnimationFinished = true
                                                            SoundManager.instance.playSound(named: "wheels moving away")
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                                                SoundManager.instance.playSound(named: "wheels moving in")
                                                            }
                                                            
                                                            withAnimation(Animation.linear(duration: 3)) {
                                                                // Set the Offset to Move the Character to the Left
                                                                greetingVariableOffset = CGSize(width: -UIScreen.main.bounds.width, height: 0)
                                                                keyFileNameVariableOffset = .zero
                                                            }
                                                            withAnimation(Animation.linear(duration: 3)) {
                                                                // Set the Offset to Move the Character to the Right
                                                                starVariableOffset = CGSize(width: UIScreen.main.bounds.width, height: 0)
                                                                gridFileNameVariableOffset = .zero
                                                                
                                                            }
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                                                                self.secondPart = true
                                                                speaker.stopSpeaking()
                                                                self.forwardButtonPressCounter += 1
                                                                self.isFirstPartAnimationInProgress = false
                                                                withAnimation{
                                                                    progressBarValue = 4/9
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    },
                                    sfSymbolName: "lock",
                                    sfSymbolFontSize: geometry.size.width * 0.035,
                                    strokeWidth: geometry.size.width * 0.0025
                                )
                                .padding(.horizontal, geometry.size.width * 0.005)
                                CircularTransparentFillButton(
                                    
                                    circleColor: (!secondPart || isSecondPartAnimationFinished) ? (modesViewModel.highContrastModeON ? Color("pacificBliss") : Color("icy")) : (modesViewModel.highContrastModeON ? (isSecondPartAnimationInProgress ? Color("porcelainRose") : Color("regalBlue")) : (isSecondPartAnimationInProgress ? Color("creamyPeach") : Color("honestBlue"))),
                                    
                                    circleFrameWidth: geometry.size.width * 0.05,
                                    symbolColor: modesViewModel.highContrastModeON ? Color("eyeball") : Color("floralWhite"),
                                    action: {
                                        if secondPart && !isSecondPartAnimationInProgress && !isSecondPartAnimationFinished{
                                            
                                            SoundManager.instance.playSound(named: "click")
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                                                SoundManager.instance.playSound(named: "unlocking")
                                            }
                                            
                                            isSecondPartAnimationInProgress = true
                                            withAnimation(Animation.easeOut(duration: 1)) {
                                                // Set opacity to 0 to make the image fade out
                                                filesOpacity = 0.0
                                            }
                                            withAnimation(Animation.easeIn(duration: 1)) {
                                                // Set opacity to 1 to make the images fade in
                                                leftVariableOpacity = 1.0
                                                rightVariableOpacity = 1.0
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                                withAnimation(Animation.easeIn(duration: 1)) {
                                                    // Set opacity to 0 to make the images fade out
                                                    leftVariableOpacity = 0.0
                                                    rightVariableOpacity = 0.0
                                                }
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2){
                                                    isSecondPartAnimationInProgress = false
                                                    isSecondPartAnimationFinished = true
                                                    speaker.stopSpeaking()
                                                    withAnimation{
                                                        self.currentGameState = .loopArray
                                                    }
                                                    self.currentModesViewModelState = modesViewModel
                                                    softHaptic()
                                                }
                                            }
                                        }
                                    },
                                    sfSymbolName: "paperplane",
                                    sfSymbolFontSize: geometry.size.width * 0.035,
                                    strokeWidth: geometry.size.width * 0.0025
                                )
                                .padding(.horizontal, geometry.size.width * 0.005)
                                CirclepathButton(
                                    
                                    circleColor: modesViewModel.highContrastModeON ? Color("pacificBliss") : Color("icy"),
                                    
                                    circleFrameWidth: geometry.size.width * 0.05,
                                    symbolWidth: geometry.size.width * 0.045,
                                    strokeWidth: geometry.size.width * 0.0025,
                                    modesViewModel: modesViewModel
                                )
                                .padding(.horizontal, geometry.size.width * 0.005)
                            }
                            .padding(.bottom, geometry.size.height * 0.015)
                        }
                        
                    }
                }
                    .position(x: geometry.size.width * 0.855, y: geometry.size.height * 0.55)
                    
                   
                
                ZStack {
                    HStack{
                        ZStack {
                            Image(modesViewModel.highContrastModeON ? "greeting variable HC" : "greeting variable")
                                .resizable()
                                .interpolation(.high)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.29)
                                .position(x: geometry.size.width * 0.16, y: geometry.size.height * 0.665)
                            
                            Image(modesViewModel.highContrastModeON ? "greeting variable white HC" : "greeting variable white")
                                .resizable()
                                .interpolation(.high)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.29)
                                .position(x: geometry.size.width * 0.16, y: geometry.size.height * 0.665)
                                .opacity(leftVariableOpacity)
                        }
                        .offset(greetingVariableOffset)
                        
                        ZStack {
                            Image(modesViewModel.highContrastModeON ? "number variable talking HC" : "number variable talking")
                                .resizable()
                                .interpolation(.high)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.26)
                                .position(x: geometry.size.width * 0.04, y: geometry.size.height * 0.673)
                            
                            Image(modesViewModel.highContrastModeON ? "number variable white talking HC" : "number variable white talking")
                                .resizable()
                                .interpolation(.high)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.26)
                                .position(x: geometry.size.width * 0.04, y: geometry.size.height * 0.673)
                                .opacity(numberVariableOpacity)
                        }
                        
                        ZStack {
                            Image(modesViewModel.highContrastModeON ? "star variable HC" : "star variable")
                                .resizable()
                                .interpolation(.high)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.26)
                                .position(x: -geometry.size.width * 0.082, y: geometry.size.height * 0.666)
                            
                            Image(modesViewModel.highContrastModeON ? "star variable white HC" : "star variable white")
                                .resizable()
                                .interpolation(.high)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.26)
                                .position(x: -geometry.size.width * 0.082, y: geometry.size.height * 0.666)
                                .opacity(rightVariableOpacity)
                        }
                        .offset(starVariableOffset)
                    }
                    HStack{
                        ZStack {
                            Image(modesViewModel.highContrastModeON ? "keyFileName variable HC" : "keyFileName variable")
                                .resizable()
                                .interpolation(.high)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.262)
                                .position(x: geometry.size.width * 0.1605, y: geometry.size.height * 0.661)
                            
                            Image(modesViewModel.highContrastModeON ? "keyFileName variable white HC" : "keyFileName variable white")
                                .resizable()
                                .interpolation(.high)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.262)
                                .position(x: geometry.size.width * 0.1605, y: geometry.size.height * 0.661)
                                .opacity(leftVariableOpacity)
                        }
                        .offset(keyFileNameVariableOffset)
                        
                        ZStack {
                            Image(modesViewModel.highContrastModeON ? "gridFileName variable HC" : "gridFileName variable")
                                .resizable()
                                .interpolation(.high)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.262)
                                .position(x: geometry.size.width * 0.086, y: geometry.size.height * 0.685)
                            
                            Image(modesViewModel.highContrastModeON ? "gridFileName variable white HC" : "gridFileName variable white")
                                .resizable()
                                .interpolation(.high)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.262)
                                .position(x: geometry.size.width * 0.086, y: geometry.size.height * 0.685)
                                .opacity(rightVariableOpacity)
                        }
                        .offset(gridFileNameVariableOffset)
                    }
                }
                
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
    VariablesView(currentGameState: .constant(.variables), currentModesViewModelState: .constant(ModesViewModel()))
}

