import SwiftUI

struct ContentView: View {
    @State private var screenTimeHours: Double = 10
    @State private var readingSpeedWPM: Double = 250
    @State private var bookWordCount: Double = 75000
    @State private var booksMissed: Double = 0.0

    var body: some View {
        ZStack {
            Color(red: 24/255, green: 24/255, blue: 27/255)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    Text("books unread")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, 20)

                    VStack(spacing: 16) {
                        StatCard(
                            title: "screen time",
                            value: "\(Int(screenTimeHours)) hours",
                            sliderValue: $screenTimeHours,
                            range: 0...100,
                            step: 1
                        )

                        StatCard(
                            title: "reading speed",
                            value: "\(Int(readingSpeedWPM)) wpm",
                            sliderValue: $readingSpeedWPM,
                            range: 50...500,
                            step: 10
                        )

                        StatCard(
                            title: "book length",
                            value: "\(Int(bookWordCount)) words",
                            sliderValue: $bookWordCount,
                            range: 10000...200000,
                            step: 1000
                        )
                    }
                    .padding(.horizontal)

                    Button(action: calculateBooks) {
                        Text("calculate")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal)

                    VStack(spacing: 8) {
                        Text("unread books:")
                            .font(.title2)
                            .foregroundColor(.white)

                        Text("\(booksMissed, specifier: "%.1f")")
                            .font(.system(size: 56, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 40)
                }
            }
        }
    }

    func calculateBooks() {
        let totalWordsRead = screenTimeHours * 60 * readingSpeedWPM
        withAnimation {
            booksMissed = totalWordsRead / bookWordCount
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    @Binding var sliderValue: Double
    let range: ClosedRange<Double>
    let step: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Text(value)
                    .font(.subheadline)
                    .foregroundColor(.white)
            }

            Slider(value: $sliderValue, in: range, step: step)
                .accentColor(.white)
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
    }
}

#Preview {
    ContentView()
}
