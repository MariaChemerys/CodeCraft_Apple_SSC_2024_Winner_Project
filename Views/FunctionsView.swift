
import SwiftUI
import AVFoundation

struct FunctionsView: View {
    
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
    @State var progressBarValue: Double = 7/9
    
    // Variables to Make the Characters Fade In
    @State var fileToArrayActiveOpacity: Double = 0.0
    @State var numberToColorActiveOpacity: Double = 0.0
    @State var gridFileNameVariableOpacity: Double = 0.0
    @State var keyFileNameVariableOpacity: Double = 0.0
    
    // Variables to Make the Characters and Items Fade Out
    @State var screenGridFileNameVariableOpacity: Double = 1.0
    @State var numberGridArrayOpacity: Double = 1.0
    @State var screenNumberGridArrayOpacity: Double = 1.0
    @State var screenKeyFileNameVariableOpacity: Double = 1.0
    
    // Variables for the Array's Elements Animation
    let numbers = [8, 4, 1, 7, 2, 3]
    @State private var rotation: Double = 30.0
    @State var currentElementIndex: Int = 4
    @State var circleDecreased: Bool = false
    
    // Variables to Know Whether Animations are in Progress and Buttons to Go to the Next/Last Screen are Available
    @State private var isFirstPartAnimationInProgress: Bool = false
    @State private var isValuesAnimationFinished: Bool = false
    @State private var isSecondPartAnimationInProgress: Bool = false
    @State private var isSecondPartAnimationFinished: Bool = false
    @State private var isGridFileNameAnimationFinished: Bool = false
    @State private var isGridFileNameAnimationInProgress: Bool = false
    @State private var isNumberGridAnimationFinished: Bool = false
    @State private var isNumberGridAnimationInProgress: Bool = false
    @State private var isMargaretHamiltonAnimationON: Bool = false
    
    var body: some View {
        
        ZStack{
            GeometryReader {
                geometry in
                
                if !secondPart {
                    ZStack{
                        Image(modesViewModel.highContrastModeON ? "fileToArray inactive talking HC" : "fileToArray inactive talking")
                            .resizable()
                            .interpolation(.high)
                            .aspectRatio(contentMode: .fit)
                        
                        Image(modesViewModel.highContrastModeON ? "fileToArray active talking HC" : "fileToArray active talking")
                            .resizable()
                            .interpolation(.high)
                            .aspectRatio(contentMode: .fit)
                            .opacity(fileToArrayActiveOpacity)
                    }
                    .frame(width: geometry.size.width * 0.2)
                    .position(x: geometry.size.width * 0.31, y: geometry.size.height * 0.69)
                    
                    ZStack{
                        Image(modesViewModel.highContrastModeON ? "gridFileName variable stand HC" : "gridFileName variable stand")
                            .resizable()
                            .interpolation(.high)
                            .aspectRatio(contentMode: .fit)
                        
                        Image(modesViewModel.highContrastModeON ? "gridFileName variable on stand HC" : "gridFileName variable on stand")
                            .resizable()
                            .interpolation(.high)
                            .aspectRatio(contentMode: .fit)
                            .opacity(gridFileNameVariableOpacity)
                    }
                    .frame(width: geometry.size.width * 0.2)
                    .position(x: geometry.size.width * 0.13, y: geometry.size.height * 0.695)
                    
                    ZStack{
                        Image(modesViewModel.highContrastModeON ? "numberGrid array white on stand HC" : "numberGrid array white on stand")
                            .resizable()
                            .interpolation(.high)
                            .aspectRatio(contentMode: .fit)
                        
                        Image(modesViewModel.highContrastModeON ? "numberGrid array on stand HC" : "numberGrid array on stand")
                            .resizable()
                            .interpolation(.high)
                            .aspectRatio(contentMode: .fit)
                            .opacity(numberGridArrayOpacity)
                        
                    }
                    .frame(width: geometry.size.width * 0.33)
                    .position(x: geometry.size.width * 0.55, y: geometry.size.height * 0.655)
                }
                else{
                    
                    ZStack{
                        Image(modesViewModel.highContrastModeON ? "numberGrid array stand HC" : "numberGrid array stand")
                            .resizable()
                            .interpolation(.high)
                            .aspectRatio(contentMode: .fit)
                        
                        Image(modesViewModel.highContrastModeON ? "numberGrid array on stand HC" : "numberGrid array on stand")
                            .resizable()
                            .interpolation(.high)
                            .aspectRatio(contentMode: .fit)
                            .opacity(numberGridArrayOpacity)
                        
                    }
                    .frame(width: geometry.size.width * 0.25)
                    .position(x: geometry.size.width * 0.271, y: geometry.size.height * 0.698)
                    
                    ZStack{
                        Image(modesViewModel.highContrastModeON ? "keyFileName variable stand HC" : "keyFileName variable stand")
                            .resizable()
                            .interpolation(.high)
                            .aspectRatio(contentMode: .fit)
                        
                        Image(modesViewModel.highContrastModeON ? "keyFileName variable on stand HC" : "keyFileName variable on stand")
                            .resizable()
                            .interpolation(.high)
                            .aspectRatio(contentMode: .fit)
                            .opacity(keyFileNameVariableOpacity)
                    }
                    .frame(width: geometry.size.width * 0.15)
                    .position(x: geometry.size.width * 0.1, y: geometry.size.height * 0.7165)
                    
                    ZStack {
                        Image(modesViewModel.highContrastModeON ? "loop on chair HC" : "loop on chair")
                            .resizable()
                            .interpolation(.high)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.15)
                        
                        
                        ZStack {
                            Image(modesViewModel.highContrastModeON ? "loop circle HC" : "loop circle")
                                .resizable()
                                .interpolation(.high)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.23)
                                .scaleEffect(circleDecreased ? 0.9 : 1.0)
                            
                            if isNumberGridAnimationFinished && !isSecondPartAnimationFinished{
                                ZStack {
                                    ForEach(0..<6) { index in
                                        circularElement(index: index, maxWidth: geometry.size.width, maxHeight: geometry.size.height, currentElementIndex: currentElementIndex, modesViewModel: modesViewModel)
                                    }
                                }
                                .rotationEffect(.degrees(rotation))
                            }
                            
                        }.padding(.bottom, geometry.size.height * 0.16)
                        
                    }
                    .frame(width: geometry.size.width * 0.04)
                    .position(x: geometry.size.width * 0.49, y: geometry.size.height * 0.675)
                    
                    ZStack{
                        Image(modesViewModel.highContrastModeON ? "numberToColor inactive talking HC" : "numberToColor inactive talking")
                            .resizable()
                            .interpolation(.high)
                            .aspectRatio(contentMode: .fit)
                        
                        Image(modesViewModel.highContrastModeON ? "numberToColor active talking HC" : "numberToColor active talking")
                            .resizable()
                            .interpolation(.high)
                            .aspectRatio(contentMode: .fit)
                            .opacity(numberToColorActiveOpacity)
                    }
                    .frame(width: geometry.size.width * 0.15)
                    .position(x: geometry.size.width * 0.645, y: geometry.size.height * 0.725)
                    
                }
                
                VoiceoverSign(
                    symbolColor: modesViewModel.highContrastModeON ? Color("regalBlue"): Color.white,
                    sfSymbolFontSize: geometry.size.width  * 0.02)
                .position(x: geometry.size.width * 0.968, y: geometry.size.height * 0.028)
                
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
                                    
                                    self.isValuesAnimationFinished = false
                                    self.isGridFileNameAnimationFinished = false
                                    self.isNumberGridAnimationFinished = false
                                    self.isMargaretHamiltonAnimationON = false
                                    self.isSecondPartAnimationFinished = false
                                    self.rotation = 30
                                    self.currentElementIndex = 4
                                    self.fileToArrayActiveOpacity = 0.0
                                    self.numberGridArrayOpacity = 1.0
                                    self.gridFileNameVariableOpacity = 0.0
                                    self.keyFileNameVariableOpacity = 0.0
                                    self.screenGridFileNameVariableOpacity = 1.0
                                    self.screenNumberGridArrayOpacity = 1.0
                                    self.screenKeyFileNameVariableOpacity = 1.0
                                    
                                    withAnimation{
                                        self.progressBarValue = 7/9
                                    }
                                }
                                else if forwardButtonPressCounter == (-1){
                                    withAnimation{
                                        self.currentGameState = .loopArray
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
                                    speaker.speak(textToSpeak: modesViewModel.isENG ? TextBlocksContentViewModel.instance.functionsContent[0].contentENG : TextBlocksContentViewModel.instance.functionsContent[0].contentUA, modesViewModel: modesViewModel, identifier: modesViewModel.isENG ? "com.apple.voice.compact.en-US.Samantha" : "com.apple.voice.compact.uk-UA.Lesya")
                                }
                                else{
                                    speaker.speak(textToSpeak: modesViewModel.isENG ? TextBlocksContentViewModel.instance.functionsContent[1].contentENG : TextBlocksContentViewModel.instance.functionsContent[1].contentUA, modesViewModel: modesViewModel, identifier: modesViewModel.isENG ? "com.apple.voice.compact.en-US.Samantha" : "com.apple.voice.compact.uk-UA.Lesya")
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
                            content: secondPart ? (modesViewModel.isENG ? TextBlocksContentViewModel.instance.functionsContent[1].contentENG : TextBlocksContentViewModel.instance.functionsContent[1].contentUA) : (modesViewModel.isENG ? TextBlocksContentViewModel.instance.functionsContent[0].contentENG : TextBlocksContentViewModel.instance.functionsContent[0].contentUA),
                            fontSize: modesViewModel.isENG ? geometry.size.width * 0.021 : geometry.size.width * 0.02,
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
                                ZStack {
                                    VStack{
                                        if !secondPart{
                                            if !isGridFileNameAnimationFinished{
                                                VStack {
                                                    Image(modesViewModel.highContrastModeON ? "gridFileName variable HC" : "gridFileName variable")
                                                        .resizable()
                                                        .interpolation(.high)
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(height: geometry.size.height * 0.105)
                                                    
                                                    Text("gridFileName")
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
                                                        .frame(width: geometry.size.width * 0.16)
                                                    
                                                )
                                                .opacity(screenGridFileNameVariableOpacity)
                                            }
                                            else{
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
                                            }
                                            VStack {
                                                VStack {
                                                    Image(modesViewModel.highContrastModeON ? "keyFileName variable HC" : "keyFileName variable")
                                                        .resizable()
                                                        .interpolation(.high)
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(height: geometry.size.height * 0.105)
                                                    
                                                    
                                                    Text("keyFileName")
                                                        .font(Font.custom("Menlo", size: geometry.size.width * 0.021))
                                                        .bold()
                                                }
                                                
                                                Rectangle()
                                                    .frame(width: geometry.size.width * 0.22, height: geometry.size.height * 0.004)
                                            }
                                        }
                                        else{
                                            if !isNumberGridAnimationFinished{
                                                VStack {
                                                    Image(modesViewModel.highContrastModeON ? "numberGrid array HC" : "numberGrid array")
                                                        .resizable()
                                                        .interpolation(.high)
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(height: geometry.size.height * 0.105)
                                                    
                                                    Text("numberGrid")
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
                                                        .frame(width: geometry.size.width * 0.16)
                                                    
                                                )
                                                .opacity(screenNumberGridArrayOpacity)
                                                
                                                VStack(spacing: 0) {
                                                    Image(modesViewModel.highContrastModeON ? "keyFileName variable HC" : "keyFileName variable")
                                                        .resizable()
                                                        .interpolation(.high)
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(height: geometry.size.height * 0.105)
                                                    
                                                    Text("keyFileName")
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
                                                        .frame(width: geometry.size.width * 0.16)
                                                    
                                                )
                                                .opacity(screenKeyFileNameVariableOpacity)
                                                Rectangle()
                                                    .frame(width: geometry.size.width * 0.22, height: geometry.size.height * 0.004)
                                                    .padding(.top, geometry.size.height * 0.005)
                                            }
                                            else{
                                                if isMargaretHamiltonAnimationON{
                                                    VStack{
                                                        AnimationView(scene: MargaretHamiltonScene())
                                                            .allowsHitTesting(false)
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(height: geometry.size.height * 0.294)
                                                        Text(modesViewModel.isENG ? "Margaret Hamilton" : "Маргарет Гамільтон")
                                                            .font(Font.custom("Menlo", size: geometry.size.width * 0.019))
                                                            .bold()
                                                            .padding(geometry.size.width * 0.005)
                                                    }
                                                }
                                            }
                                            
                                        }
                                    }
                                    .padding(.top)
                                }
                                
                                .padding(.bottom, geometry.size.height * 0.013)
                                
                            }
                            .frame(height: geometry.size.height * 0.36)
                            
                            if !isNumberGridAnimationFinished{
                                HStack{
                                    CircularTransparentFillButton(
                                        circleColor: modesViewModel.highContrastModeON ? Color("pacificBliss") : Color("icy"),
                                        circleFrameWidth: geometry.size.width * 0.05,
                                        symbolColor: modesViewModel.highContrastModeON ? Color("eyeball") : Color("floralWhite"),
                                        sfSymbolName: "lock",
                                        sfSymbolFontSize: geometry.size.width * 0.035,
                                        strokeWidth: geometry.size.width * 0.0025
                                    )
                                    .padding(.horizontal, geometry.size.width * 0.005)
                                    
                                    CircularTransparentFillButton(
                                        circleColor: (!secondPart && !isFirstPartAnimationInProgress) || (secondPart && !isSecondPartAnimationInProgress && !isSecondPartAnimationFinished) ? (modesViewModel.highContrastModeON ? Color("regalBlue") : Color("honestBlue")) : (modesViewModel.highContrastModeON ? ( isGridFileNameAnimationInProgress || isNumberGridAnimationInProgress ? Color("porcelainRose") : Color("pacificBliss")) : (isGridFileNameAnimationInProgress || isNumberGridAnimationInProgress ? Color("creamyPeach") : Color("icy"))),
                                        circleFrameWidth: geometry.size.width * 0.05,
                                        symbolColor: modesViewModel.highContrastModeON ? Color("eyeball") : Color("floralWhite"),
                                        action: {
                                            if !secondPart && !isFirstPartAnimationInProgress{
                                                self.isFirstPartAnimationInProgress = true
                                                self.isGridFileNameAnimationInProgress = true
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                                    SoundManager.instance.playSound(named: "unlocking")
                                                }
                                                
                                                withAnimation(Animation.easeIn(duration: 1.5)) {
                                                    gridFileNameVariableOpacity = 1
                                                }
                                                withAnimation(Animation.easeOut(duration: 1.5)) {
                                                    screenGridFileNameVariableOpacity = 0
                                                }
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                                    self.isGridFileNameAnimationFinished = true
                                                    self.isGridFileNameAnimationInProgress = false
                                                    
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                                                        SoundManager.instance.playSound(named: "unlocking")
                                                    }
                                                    
                                                    withAnimation(Animation.easeIn(duration: 1)) {
                                                        fileToArrayActiveOpacity = 1
                                                    }
                                                    withAnimation(Animation.easeOut(duration: 1)) {
                                                        numberGridArrayOpacity = 0
                                                    }
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                                        withAnimation(Animation.easeOut(duration: 1)) {
                                                            fileToArrayActiveOpacity = 0
                                                        }
                                                        withAnimation(Animation.easeIn(duration: 1)) {
                                                            numberGridArrayOpacity = 1
                                                        }
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                                            self.isFirstPartAnimationInProgress = false
                                                            self.secondPart = true
                                                            speaker.stopSpeaking()
                                                            self.forwardButtonPressCounter += 1
                                                            self.numberGridArrayOpacity = 0
                                                            withAnimation{
                                                                self.progressBarValue = 8/9
                                                            }
                                                        }
                                                    }
                                                }
                                                SoundManager.instance.playSound(named: "click")
                                            }
                                            if secondPart && !isSecondPartAnimationInProgress && !isSecondPartAnimationFinished{
                                                
                                                self.isSecondPartAnimationInProgress = true
                                                self.isNumberGridAnimationInProgress = true
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                                                    SoundManager.instance.playSound(named: "unlocking")
                                                }
                                                
                                                withAnimation(Animation.easeIn(duration: 1.5)) {
                                                    keyFileNameVariableOpacity = 1
                                                    numberGridArrayOpacity = 1
                                                }
                                                withAnimation(Animation.easeOut(duration: 1.5)) {
                                                    screenKeyFileNameVariableOpacity = 0
                                                    screenNumberGridArrayOpacity = 0
                                                }
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                                    self.isNumberGridAnimationInProgress = false
                                                    self.isNumberGridAnimationFinished = true
                                                    self.isMargaretHamiltonAnimationON = true
                                                    
                                                    
                                                    SoundManager.instance.playSound(named: "multiple whoosh")
                                                    
                                                    
                                                    repeatRotations(count: 13)
                                                    
                                                    withAnimation(Animation.easeIn(duration: 0.2)) {
                                                        numberToColorActiveOpacity = 1.0
                                                    }
                                                    
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                                                        withAnimation(Animation.easeOut(duration: 0.2)) {
                                                            numberToColorActiveOpacity = 0.0
                                                        }
                                                    }
                                                }
                                                
                                                SoundManager.instance.playSound(named: "click")
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
                }
                .position(x: geometry.size.width * 0.855, y: geometry.size.height * 0.55)
            }
            
        }.onAppear{
            modesViewModel.highContrastModeON = currentModesViewModelState.highContrastModeON
            modesViewModel.isENG = currentModesViewModelState.isENG
            modesViewModel.speakingRate = currentModesViewModelState.speakingRate
        }
        
        
    }
    
    // Function that Returns Elements of the Array in a Circle
    func circularElement(index: Int, maxWidth: CGFloat, maxHeight: CGFloat, currentElementIndex: Int, modesViewModel: ModesViewModel) -> some View {
        let totalItems = Double(numbers.count)
        let angle = (360.0 / totalItems) * Double(index) + rotation
        let radius = circleDecreased ? maxHeight * 0.15 : maxHeight * 0.155
        
        return  ZStack{
            RoundedRectangle(cornerRadius: maxWidth * 0.01)
                .foregroundColor(index == currentElementIndex ? (modesViewModel.highContrastModeON ? Color("artfulRed") : Color("smashedPumpkin")) : (modesViewModel.highContrastModeON ? Color("eyeball") : Color("floralWhite")))
                .frame(width: maxWidth * 0.04, height: maxWidth * 0.04)
                .background(
                    RoundedRectangle(cornerRadius: maxWidth * 0.01)
                        .foregroundColor(.black)
                        .padding(-maxWidth * 0.001)
                )
                .offset(x: radius * cos(angle * .pi / 180), y: radius * sin(angle * .pi / 180))
                .rotationEffect(.degrees(-rotation))
            
            Text("\(numbers[index])")
                .font(Font.custom("Menlo", size: maxWidth * 0.026))
                .foregroundColor(index == currentElementIndex ? (modesViewModel.highContrastModeON ? Color("eyeball") : Color("floralWhite")) : (modesViewModel.highContrastModeON ? Color("porcelainRose") : Color("creamyPeach")))
                .frame(width: 40, height: 40)
                .offset(x: radius * cos(angle * .pi / 180), y: radius * sin(angle * .pi / 180))
                .rotationEffect(.degrees(-rotation))
                .bold()
                .shadow(color: .black, radius: maxWidth * 0.0003)
                .shadow(color: .black, radius: maxWidth * 0.0003)
                .shadow(color: .black, radius: maxWidth * 0.0003)
                .shadow(color: .black, radius: maxWidth * 0.0003)
                .shadow(color: .black, radius: maxWidth * 0.0003)
                .shadow(color: .black, radius: maxWidth * 0.0003)
        }
    }
    
    // Function that Repeats the Elements' Rotation Animation
    func repeatRotations(count: Int) {
        guard count > 0 else {
            return
        }
        withAnimation(Animation.linear(duration: 0.01)) {
            self.rotation = 30
            self.circleDecreased = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                withAnimation(Animation.linear(duration: 0.01)) {
                    self.rotation = 90
                    self.circleDecreased = true
                    self.currentElementIndex = 3
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        withAnimation(Animation.linear(duration: 0.01)) {
                            self.rotation = 150
                            self.circleDecreased = false
                            self.currentElementIndex = 2
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                            withAnimation(Animation.linear(duration: 0.01)) {
                                self.rotation = 210
                                self.circleDecreased = true
                                self.currentElementIndex = 1
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                withAnimation(Animation.linear(duration: 0.01)) {
                                    self.rotation = 270
                                    self.circleDecreased = false
                                    self.currentElementIndex = 0
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                    withAnimation(Animation.linear(duration: 0.01)) {
                                        self.rotation = 330
                                        self.circleDecreased = true
                                        self.currentElementIndex = 5
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                        withAnimation(Animation.linear(duration: 0.01)) {
                                            self.rotation = 360
                                            self.circleDecreased = false
                                            self.currentElementIndex = 4
                                        }
                                        if count == 1{
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                                                self.isSecondPartAnimationFinished = true
                                                self.isSecondPartAnimationInProgress = false
                                                speaker.stopSpeaking()
                                                withAnimation{
                                                    self.currentGameState = .ending
                                                }
                                                self.currentModesViewModelState = modesViewModel
                                                softHaptic()
                                            }
                                        }
                                        repeatRotations(count: count - 1)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}

#Preview {
    FunctionsView(currentGameState: .constant(.functions), currentModesViewModelState: .constant(ModesViewModel()))
}
