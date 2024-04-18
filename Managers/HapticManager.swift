
import SwiftUI
import CoreHaptics

// Function to Run Soft Haptic Effect
func softHaptic() {
    let softHaptic = UIImpactFeedbackGenerator(style: .soft)
    softHaptic.impactOccurred()
}
