
import Foundation
import SwiftUI

// SettingsView Appears on the Screen When the User Presses the Settings Button
struct SettingsView: View {
    
    var maxWidth: CGFloat
    var maxHeight: CGFloat
    var textBackgroundColor: Color
    
    // Variable to Access Data from the ModesViewModel Class
    @ObservedObject var modesViewModel: ModesViewModel
    
    var body: some View {
        
        let strokeWidth = maxWidth * 0.003
        
        ZStack{
            Rectangle()
                .foregroundColor(Color("lowOpacityWhite"))
                .ignoresSafeArea()
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color("regalBlue"))
                .frame(width: maxWidth * 0.75, height: maxHeight * 0.5)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.black)
                        .padding(-strokeWidth)
                )
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(textBackgroundColor)
                    .frame(width: maxWidth * 0.72, height: maxHeight * 0.46)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.black)
                            .padding(-strokeWidth)
                    )
                
                // Text Content of the SettingsView
                VStack {
                    Text(modesViewModel.isENG ? textBlocksContentsViewModel.settingsContent[0].contentENG : textBlocksContentsViewModel.settingsContent[0].contentUA)
                        .font(Font.custom("Menlo", size: maxWidth * 0.03))
                        .bold()
                        .padding(.top, maxWidth * 0.01)
                    
                    Spacer()
                    
                    
                    VStack(spacing: maxHeight * 0.05) {
                        Group{
                            HStack {
                                Image(systemName: "globe")
                                    .imageScale(.large)
                                Text(modesViewModel.isENG ? textBlocksContentsViewModel.settingsContent[1].contentENG: textBlocksContentsViewModel.settingsContent[1].contentUA)
                                
                                Spacer()
                                
                                HStack(spacing: maxWidth * 0.05) {
                                    
                                    LanguageSelectionButton(maxWidth: maxWidth, maxHeight: maxHeight, modesViewModel: modesViewModel, label: "ENG", backgroundColor: modesViewModel.highContrastModeON ? (modesViewModel.isENG ? Color("porcelainRose") : Color("aircraftWhite")) : (modesViewModel.isENG  ? Color("creamyPeach") : Color("snowTiger")))
                                    
                                    LanguageSelectionButton(maxWidth: maxWidth, maxHeight: maxHeight, modesViewModel: modesViewModel, label: "UA", backgroundColor: modesViewModel.highContrastModeON ? (!modesViewModel.isENG ? Color("porcelainRose") : Color("aircraftWhite")) : (!modesViewModel.isENG  ? Color("creamyPeach") : Color("snowTiger")))
                                    
                                }
                                .padding(.horizontal, maxWidth * 0.025)
                            }
                            HStack {
                                Image(systemName: "speaker.wave.2")
                                    .imageScale(.large)
                                Text(modesViewModel.isENG ? textBlocksContentsViewModel.settingsContent[2].contentENG: textBlocksContentsViewModel.settingsContent[2].contentUA)
                                
                                Spacer()
                                
                                SpeakingRateSlider(maxWidth: maxWidth, maxHeight: maxHeight, modesViewModel: modesViewModel)
                                    .padding(.horizontal, maxWidth * 0.015)
                            }
                            HStack{
                                
                                Image(systemName: "moonphase.first.quarter")
                                    .imageScale(.large)
                                    .symbolRenderingMode(.monochrome)
                                
                                Text(modesViewModel.isENG ? textBlocksContentsViewModel.settingsContent[3].contentENG: textBlocksContentsViewModel.settingsContent[3].contentUA)
                                    .frame(width: maxWidth * 0.28)
                                
                                Spacer()
                                
                                HighContrastModeToggle(maxWidth: maxWidth, maxHeight: maxHeight, modesViewModel: modesViewModel)
                                    .padding(.horizontal, -maxWidth * 0.09)
                                Spacer()
                                
                            }
                        }
                        .font(Font.custom("Menlo", size: maxWidth * 0.025))
                        .bold()
                    }
                    .padding(.leading)
                    
                    Spacer()
                }
                .frame(width: maxWidth * 0.7, height: maxHeight * 0.46)
            }
        }
    }
}
