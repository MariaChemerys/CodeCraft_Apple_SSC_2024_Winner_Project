
import SwiftUI
import AVFoundation

struct LoopArrayView: View {
    
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
    @State var progressBarValue: Double = 5/9
    @State var isLockButtonPressed: Bool = false
    @State var areValuesSeen: Bool = false
    
    // Variable to Make the Character Fade In
    @State var arrayOfNumbersOpacity: Double = 0.0
    
    // Variables for the Array's Elements Animation
    let numbers = [8, 4, 1, 7, 5, 9]
    let numbersOrdered = [5, 7, 1, 4, 8, 9]
    @State private var rotation: Double = 30.0
    @State var currentElementIndex: Int = 4
    @State var currentOrderedElementIndex: Int = 0
    @State var circleDecreased: Bool = false
    
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
                                   
                                    self.isValuesAnimationFinished = false
                                    self.isSecondPartAnimationFinished = false
                                    self.arrayOfNumbersOpacity = 0.0
                                    self.isLockButtonPressed = false
                                    self.areValuesSeen = false
                                    self.rotation = 30
                                    self.currentElementIndex = 4
                                    self.currentOrderedElementIndex = 0
                                    
                                    withAnimation{
                                        self.progressBarValue = 5/9
                                    }
                                }
                                else if forwardButtonPressCounter == (-1){
                                    withAnimation{
                                        self.currentGameState = .variables
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
                                    speaker.speak(textToSpeak: modesViewModel.isENG ? TextBlocksContentViewModel.instance.loopArrayContent[0].contentENG : TextBlocksContentViewModel.instance.loopArrayContent[0].contentUA, modesViewModel: modesViewModel, identifier: modesViewModel.isENG ? "com.apple.voice.compact.en-US.Samantha" : "com.apple.voice.compact.uk-UA.Lesya")
                                }
                                else{
                                    speaker.speak(textToSpeak: modesViewModel.isENG ? TextBlocksContentViewModel.instance.loopArrayContent[1].contentENG : TextBlocksContentViewModel.instance.loopArrayContent[1].contentUA, modesViewModel: modesViewModel, identifier: modesViewModel.isENG ? "com.apple.voice.compact.en-US.Samantha" : "com.apple.voice.compact.uk-UA.Lesya")
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
                            content: secondPart ? (modesViewModel.isENG ? TextBlocksContentViewModel.instance.loopArrayContent[1].contentENG : TextBlocksContentViewModel.instance.loopArrayContent[1].contentUA) : (modesViewModel.isENG ? TextBlocksContentViewModel.instance.loopArrayContent[0].contentENG : TextBlocksContentViewModel.instance.loopArrayContent[0].contentUA),
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
                                        VStack {
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
                                        .padding(.top)
                                    }
                                    
                                    .padding(.bottom, geometry.size.height * 0.013)
                
                            }
                            .frame(height: geometry.size.height * 0.36)
                            
                            HStack{
                                CircularTransparentFillButton(
                                    
                                    circleColor: !isValuesAnimationFinished ? (modesViewModel.highContrastModeON ? (isLockButtonPressed ? Color("porcelainRose") : Color("regalBlue")) : (isLockButtonPressed ? Color("creamyPeach") : Color("honestBlue"))) : (modesViewModel.highContrastModeON ? Color("pacificBliss") : Color("icy")),
                                    circleFrameWidth: geometry.size.width * 0.05,
                                    symbolColor: modesViewModel.highContrastModeON ? Color("eyeball") : Color("floralWhite"),
                                    action: {
                                        if !secondPart && !isFirstPartAnimationInProgress {
                                            self.isLockButtonPressed = true
                                            self.isFirstPartAnimationInProgress = true
                                            SoundManager.instance.playSound(named: "click")
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                                                SoundManager.instance.playSound(named: "unlocking")
                                            }
                                            
                                            withAnimation(Animation.easeIn(duration: 1)) {
                                                // Set opacity to 1 to make the image fade in
                                                arrayOfNumbersOpacity = 1.0
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.65){
                                                self.areValuesSeen = true
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                                self.isFirstPartAnimationInProgress = false
                                                self.secondPart = true
                                                speaker.stopSpeaking()
                                                withAnimation{
                                                    self.progressBarValue = 6/9
                                                }
                                                self.forwardButtonPressCounter += 1
                                            }
                                            
                                            
                                        }
                                    },
                                    sfSymbolName: "lock",
                                    sfSymbolFontSize: geometry.size.width * 0.035,
                                    strokeWidth: geometry.size.width * 0.0025
                                )
                                .padding(.horizontal, geometry.size.width * 0.005)
                                CircularTransparentFillButton(
                                    
                                    circleColor:  modesViewModel.highContrastModeON ? Color("pacificBliss") : Color("icy"),
                                    
                                    circleFrameWidth: geometry.size.width * 0.05,
                                    symbolColor: modesViewModel.highContrastModeON ? Color("eyeball") : Color("floralWhite"),
                                    sfSymbolName: "paperplane",
                                    sfSymbolFontSize: geometry.size.width * 0.035,
                                    strokeWidth: geometry.size.width * 0.0025
                                )
                                .padding(.horizontal, geometry.size.width * 0.005)
                                CirclepathButton(
                                    
                                    circleColor: (!secondPart || isSecondPartAnimationFinished) ? (modesViewModel.highContrastModeON ? Color("pacificBliss") : Color("icy")) : (modesViewModel.highContrastModeON ? (isSecondPartAnimationInProgress ? Color("porcelainRose") : Color("regalBlue")) : (isSecondPartAnimationInProgress ? Color("creamyPeach") : Color("honestBlue"))),
                                    
                                    circleFrameWidth: geometry.size.width * 0.05,
                                    action: {
                                        if secondPart && !isSecondPartAnimationFinished && !isSecondPartAnimationInProgress {
                                            SoundManager.instance.playSound(named: "click")
                                            isSecondPartAnimationInProgress = true
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                                SoundManager.instance.playSound(named: "whoosh")
                                            }
                                            
                                            withAnimation(Animation.linear(duration: 1)){
                                                self.rotation = 90
                                                self.currentElementIndex = 3
                                                self.currentOrderedElementIndex = 1
                                            }
                                            withAnimation(Animation.linear(duration: 0.5)){
                                                circleDecreased = true
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                                withAnimation(Animation.linear(duration: 0.5)){
                                                    circleDecreased = false
                                                }
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                                
                                                SoundManager.instance.playSound(named: "whoosh")
                                                
                                                withAnimation(Animation.linear(duration: 1)){
                                                    self.rotation = 150
                                                    self.currentElementIndex = 2
                                                    self.currentOrderedElementIndex = 2
                                                }
                                                withAnimation(Animation.linear(duration: 0.5)){
                                                    circleDecreased = true
                                                }
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                                    withAnimation(Animation.linear(duration: 0.5)){
                                                        circleDecreased = false
                                                    }
                                                }
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                                    
                                                    SoundManager.instance.playSound(named: "whoosh")
                                                    
                                                    withAnimation(Animation.linear(duration: 1)){
                                                        self.rotation = 210
                                                        self.currentElementIndex = 1
                                                        self.currentOrderedElementIndex = 3
                                                    }
                                                    withAnimation(Animation.linear(duration: 0.5)){
                                                         circleDecreased = true
                                                    }
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                                        withAnimation(Animation.linear(duration: 0.5)){
                                                            circleDecreased = false
                                                        }
                                                    }
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                                        
                                                        SoundManager.instance.playSound(named: "whoosh")
                                                        
                                                        withAnimation(Animation.linear(duration: 1)){
                                                            self.rotation = 270
                                                            self.currentElementIndex = 0
                                                            self.currentOrderedElementIndex = 4
                                                        }
                                                        withAnimation(Animation.linear(duration: 0.5)){
                                                            circleDecreased = true
                                                        }
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                                            withAnimation(Animation.linear(duration: 0.5)){
                                                                circleDecreased = false
                                                            }
                                                        }
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                                            
                                                            SoundManager.instance.playSound(named: "whoosh")
                                                            
                                                            withAnimation(Animation.linear(duration: 1)){
                                                                self.rotation = 330
                                                                self.currentElementIndex = 5
                                                                self.currentOrderedElementIndex = 5
                                                                
                                                            }
                                                            withAnimation(Animation.linear(duration: 0.5)){
                                                                circleDecreased = true
                                                            }
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                                                withAnimation(Animation.linear(duration: 0.5)){
                                                                    circleDecreased = false
                                                                }
                                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
                                                                    self.isSecondPartAnimationFinished = true
                                                                    self.isSecondPartAnimationInProgress = false
                                                                    speaker.stopSpeaking()
                                                                    withAnimation{
                                                                        self.currentGameState = .functions
                                                                    }
                                                                    self.currentModesViewModelState = modesViewModel
                                                                    softHaptic()
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    },
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
                    Image(modesViewModel.highContrastModeON ? "arrayOfNumbers talking HC" : "arrayOfNumbers talking")
                        .resizable()
                        .interpolation(.high)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width * 0.31)
                    
                    
                    ZStack {
                        Image(modesViewModel.highContrastModeON ? "arrayOfNumbers white talking HC" : "arrayOfNumbers white talking")
                            .resizable()
                            .interpolation(.high)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.31)
                            .opacity(arrayOfNumbersOpacity)
                        
                        if areValuesSeen{
                            VStack(spacing: geometry.size.height * 0.00005) {
                                HStack(spacing: geometry.size.width * 0.045){
                                    ForEach(0..<3) { index in
                                        arrayOfNumbersElements(index: index, maxWidth: geometry.size.width, maxHeight: geometry.size.height, currentElementIndex: currentElementIndex, modesViewModel: modesViewModel)
                                    }
                                }
                                
                                HStack(spacing: geometry.size.width * 0.045){
                                    ForEach(3..<6) { index in
                                        arrayOfNumbersElements(index: index, maxWidth: geometry.size.width, maxHeight: geometry.size.height, currentElementIndex: currentElementIndex, modesViewModel: modesViewModel)
                                    }
                                }
                            }
                            .padding(.top, geometry.size.height * 0.133)
                        }
                    }
                    
                }
                .frame(width: geometry.size.width * 0.3)
                .position(x: geometry.size.width * 0.18, y: geometry.size.height * 0.705)
                
                ZStack {
                    Image(modesViewModel.highContrastModeON ? "loop on chair HC" : "loop on chair")
                        .resizable()
                        .interpolation(.high)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width * 0.19)
                    
                    
                    ZStack {
                        Image(modesViewModel.highContrastModeON ? "loop circle HC" : "loop circle")
                            .resizable()
                            .interpolation(.high)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.33)
                            .scaleEffect(circleDecreased ? 0.8 : 1.0)
                        
                        if areValuesSeen {
                            ZStack {
                                ForEach(0..<6) { index in
                                    circularElement(index: index, maxWidth: geometry.size.width, maxHeight: geometry.size.height, currentElementIndex: currentElementIndex, modesViewModel: modesViewModel)
                                }
                            }
                            .rotationEffect(.degrees(rotation))
                        }
                    }.padding(.bottom, geometry.size.height * 0.2)
                    
                }
                .frame(width: geometry.size.width * 0.04)
                .position(x: geometry.size.width * 0.526, y: geometry.size.height * 0.62)
                
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
    
    // Function that Returns Elements of the Array in a Circle
    func circularElement(index: Int, maxWidth: CGFloat, maxHeight: CGFloat, currentElementIndex: Int, modesViewModel: ModesViewModel) -> some View {
        let totalItems = Double(numbers.count)
        let angle = (360.0 / totalItems) * Double(index) + rotation
        let radius: CGFloat = maxHeight * 0.22
        
        return  ZStack{
            RoundedRectangle(cornerRadius: maxWidth * 0.01)
                .foregroundColor(index == currentElementIndex ? (modesViewModel.highContrastModeON ? Color("artfulRed") : Color("smashedPumpkin")) : (modesViewModel.highContrastModeON ? Color("eyeball") : Color("floralWhite")))
                .frame(width: maxWidth * 0.055, height: maxWidth * 0.055)
                .background(
                    RoundedRectangle(cornerRadius: maxWidth * 0.01)
                        .foregroundColor(.black)
                        .padding(-maxWidth * 0.002)
                )
                .offset(x: radius * cos(angle * .pi / 180), y: radius * sin(angle * .pi / 180))
                .rotationEffect(.degrees(-rotation))
            
            Text("\(numbers[index])")
                .font(Font.custom("Menlo", size: maxWidth * 0.035))
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
    
    // Function that Returns the Elements of the arrayOfNumbers With the Current Element Highlighted
    func arrayOfNumbersElements(index: Int, maxWidth: CGFloat, maxHeight: CGFloat, currentElementIndex: Int, modesViewModel: ModesViewModel) -> some View {
        
        return  HStack{
            Text("\(numbersOrdered[index])")
                .font(Font.custom("Menlo", size: maxWidth * 0.042))
                .foregroundColor(index == currentOrderedElementIndex ? (modesViewModel.highContrastModeON ? Color("artfulRed") : Color("smashedPumpkin")) : (modesViewModel.highContrastModeON ? Color("porcelainRose") : Color("creamyPeach")))
                .bold()
                .shadow(color: .black, radius: maxWidth * 0.0003)
                .shadow(color: .black, radius: maxWidth * 0.0003)
                .shadow(color: .black, radius: maxWidth * 0.0003)
                .shadow(color: .black, radius: maxWidth * 0.0003)
                .shadow(color: .black, radius: maxWidth * 0.0003)
                .shadow(color: .black, radius: maxWidth * 0.0003)
        }
        
    }
}



#Preview {
    LoopArrayView(currentGameState: .constant(.loopArray), currentModesViewModelState: .constant(ModesViewModel()))
}
