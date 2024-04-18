

import Foundation
import SwiftUI

// Language Selection Buttons
struct LanguageSelectionButton: View{
    
    var maxWidth: CGFloat
    var maxHeight: CGFloat
    var modesViewModel: ModesViewModel
    var label: String
    var backgroundColor: Color
    
    var body: some View {
        
        Button(action: {
            if label == "ENG" && modesViewModel.isENG == false{
                self.modesViewModel.isENG = true
            }
            else if label == "UA" && modesViewModel.isENG == true{
                self.modesViewModel.isENG = false
            }
            SoundManager.instance.playSound(named: "click")
        }) {
                Text(label)
                    .foregroundColor(.black)
                
                Image("\(label) icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        .frame(width: maxWidth * 0.1, height: maxHeight * 0.04)
        .background(
            RoundedRectangle(cornerRadius: maxWidth * 0.05)
                .padding(-maxWidth * 0.006)
                .frame(width: maxWidth * 0.1)
                .foregroundColor(backgroundColor)
                .background(
                RoundedRectangle(cornerRadius: maxWidth * 0.05)
                    .foregroundColor(.black)
                    .padding(-maxWidth * 0.009)
                )
        )
    }
}

// Speaking Rate Slider
struct SpeakingRateSlider: View {
    
    var maxWidth: CGFloat
    var maxHeight: CGFloat
    
    @ObservedObject var modesViewModel: ModesViewModel
    
    var body: some View {     
        
        let strokeWidth = maxWidth * 0.003
        
        GeometryReader { geometry in
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: maxWidth * 0.005)
                    .frame(height: maxHeight * 0.008)
                    .foregroundColor(modesViewModel.highContrastModeON ? Color("aircraftWhite") : Color("snowTiger"))
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.black)
                            .padding(-strokeWidth)
                    )
                RoundedRectangle(cornerRadius: maxWidth * 0.005)
                    .frame(width: maxWidth * 0.268 * CGFloat(modesViewModel.speakingRate), height: maxHeight * 0.008)
                    .foregroundColor(modesViewModel.highContrastModeON ? Color("porcelainRose") : Color("creamyPeach"))
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.black)
                            .padding(-strokeWidth)
                    )
                ZStack{
                    Circle()
                        .foregroundColor(modesViewModel.highContrastModeON ? Color("eyeball") : Color ("floralWhite"))
                        .frame(width: maxWidth * 0.04)
                        .background(
                            Circle()
                                .foregroundColor(.black)
                                .padding(-strokeWidth)
                        )
//                    Text("\(Int(modesViewModel.speakingRate * 100))")
                }
                .offset(x: CGFloat(CGFloat(modesViewModel.speakingRate) * geometry.size.width * 0.9))
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged{ gesture in
                            updateSliderValue(with: gesture, in: geometry)
                        }
                )
            }
            .padding(.top, maxWidth * 0.006)
        }
        .frame(width: maxWidth * 0.268, height: maxHeight * 0.08)
    }
    
    func updateSliderValue(with gesture: DragGesture.Value, in geometry: GeometryProxy){
        let newValue = gesture.location.x / geometry.size.width
        modesViewModel.speakingRate = min(max(Float(newValue), 0), 1)
    }
}

// High Contrast Mode ON/OFF Toggle
struct HighContrastModeToggle: View{
    
    var maxWidth: CGFloat
    var maxHeight: CGFloat
    
    @ObservedObject var modesViewModel: ModesViewModel
    
    var body: some View{
        
        let highContrastModeON: Bool = modesViewModel.highContrastModeON
        let strokeWidth = maxWidth * 0.003
        
        ZStack{
            RoundedRectangle(cornerRadius: maxWidth * 0.05)
                .foregroundColor( highContrastModeON ? Color("porcelainRose") : Color("snowTiger"))
                .background(
                    RoundedRectangle(cornerRadius: maxWidth * 0.05)
                        .foregroundColor(.black)
                        .padding(-strokeWidth)
                )
            Circle()
                .foregroundColor(highContrastModeON ? Color("eyeball") : Color("floralWhite"))
                .background(
                Circle()
                    .foregroundColor(.black)
                    .padding(-strokeWidth)
                )
                .offset(x: modesViewModel.highContrastModeON ? maxWidth * 0.019 : -maxWidth * 0.019)
        }
            .frame(width: maxWidth * 0.08, height: maxHeight * 0.062)
            .onTapGesture {
                withAnimation(.spring()){
                    modesViewModel.highContrastModeON.toggle()
                }
                SoundManager.instance.playSound(named: "toggle")
            }
            
    }
}
