//
//  ContentView.swift
//  Knob
//
//  Created by Chris Eidhof on 05.11.19.
//  Copyright © 2019 Chris Eidhof. All rights reserved.
//

import SwiftUI

private extension Double {
    static let colorSaturation = Double(0.8)
    static let colorBrightness = Double(1)
}

struct KnobShape: Shape {
    var pointerSize: CGFloat
    var pointerWidth: CGFloat = 0.1

    func path(in rect: CGRect) -> Path {
        let pointerHeight = rect.height * pointerSize
        let pointerWidth = rect.width * self.pointerWidth
        let circleRect = rect.insetBy(dx: pointerHeight, dy: pointerHeight)
        return Path { p in
            p.addEllipse(in: circleRect)
            p.addRect(CGRect(x: rect.midX - pointerWidth/2, y: 0, width: pointerWidth, height: pointerHeight + 2))
        }
    }
}

struct Knob: View {
    @Binding var value: Double // should be between 0 and 1
    @Environment(\.knobColor) var color
    @Environment(\.knobPointerSize) var pointerSize

    var body: some View {
         KnobShape(pointerSize: pointerSize)
            .fill(color)
            .rotationEffect(Angle(degrees: value * 330))
            .onTapGesture {
                withAnimation(.default) {
                    self.value = self.value < 0.5 ? 1 : 0
                }
            }
    }
}

struct ContentView: View {
    @State var value: Double = 0.5
    @State var knobSize: CGFloat = 0.1
    @State var colorHue: Double = 0

    var body: some View {
        VStack {
            Knob(value: $value)
                .frame(width: 100, height: 100)
                .knobColor(Color(hue: colorHue,
                                 saturation: .colorSaturation,
                                 brightness: .colorBrightness))
                .knobPointerSize(knobSize)
            HStack {
                Text("Value")
                Slider(value: $value, in: 0...1)
            }
            HStack {
                Text("Knob Size")
                Slider(value: $knobSize, in: 0...0.4)
            }
            HStack {
                Text("Color hue")
                Slider(value: $colorHue, in: 0...1)
            }
            Button("Toggle", action: {
                withAnimation(.default) {
                    self.value = self.value == 0 ? 1 : 0
                }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
