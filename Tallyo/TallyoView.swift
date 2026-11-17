import SwiftUI
import UIKit

struct TallyoView: View {
    @StateObject private var tallyo = TallyoViewModel()

    var body: some View {
        VStack(spacing: 32) {

            // Limit picker
            VStack(spacing: 8) {
                Text("Limit")
                    .font(.headline)
                    .foregroundStyle(.secondary)

                Picker("Limit", selection: $tallyo.limit) {
                    ForEach(TallyoLimit.allCases) { limit in
                        Text(limit.title).tag(limit)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding(.horizontal)

            Spacer()

            // Circular tap button with progress ring
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 14)

                Circle()
                    .trim(from: 0, to: tallyo.progress)
                    .stroke(
                        tallyo.isAtLimit ? Color.green : Color.blue,
                        style: StrokeStyle(lineWidth: 14, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut(duration: 0.2), value: tallyo.progress)

                Button(action: tap) {
                    VStack(spacing: 4) {
                        Text("\(tallyo.count)")
                            .font(.system(size: 72, weight: .bold, design: .rounded))
                            .monospacedDigit()
                            .contentTransition(.numericText())
                        Text(tallyo.isAtLimit ? "Limit reached" : "of \(tallyo.limit.rawValue)")
                            .font(.subheadline)
                            .opacity(0.8)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(tallyo.isAtLimit ? Color.green : Color.blue)
                    .clipShape(Circle())
                }
                .buttonStyle(TallyoPressStyle())
                .disabled(tallyo.isAtLimit)
                .padding(24)
                .accessibilityLabel("Count \(tallyo.count) of \(tallyo.limit.rawValue)")
                .accessibilityHint("Double tap to increase the count")
            }
            .frame(width: 280, height: 280)

            Spacer()

            // Reset
            Button(role: .destructive) {
                tallyo.reset()
                UINotificationFeedbackGenerator().notificationOccurred(.warning)
            } label: {
                Label("Reset", systemImage: "arrow.counterclockwise")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .padding(.horizontal)
            .disabled(tallyo.count == 0)
        }
        .padding(.vertical)
        .animation(.default, value: tallyo.limit)
    }

    private func tap() {
        if tallyo.increment() {
            if tallyo.isAtLimit {
                UINotificationFeedbackGenerator().notificationOccurred(.success)
            } else {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
        }
    }
}

#Preview {
    TallyoView()
}
