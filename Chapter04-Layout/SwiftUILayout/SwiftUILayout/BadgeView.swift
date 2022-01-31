//
//  BadgeView.swift
//  SwiftUILayout
//
//  Created by Domagoj Eklic on 1/30/22.
//

import SwiftUI

struct BadgeTestView: View {
    @State
    private var count = 4

    var body: some View {
        VStack {
            Text("Hello")
                .padding(10)
                .background(Color.gray)
                .badge(count: count)

            HStack {
                Button(action: { withAnimation(.default) {
                    count += 1
                }}, label: {
                    Text("+")
                })

                Button(action: { withAnimation(.default) {
                    guard count >= 1 else {
                        return
                    }

                    count -= 1
                }}, label: {
                    Text("-")
                })
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

// MARK: Badge Modifier

struct BadgeModifier: ViewModifier {
    var count: Int

    func body(content: Content) -> some View {
        content.overlay(
            badgeView()
                .frame(width: 28, height: 28)
                .offset(x: 14, y: -14)
                .opacity(count > 0 ? 1 : 0)
            ,alignment: .topTrailing)
    }

    private func badgeView() -> some View {
        ZStack(alignment: .center) {
            Circle()
                .fill(Color.red)
            Text("\(count)")
                .foregroundColor(.white)
                .font(.system(.headline, design: .monospaced))
        }
    }
}

// MARK: badge(count:) View extension

extension View {

    func badge(count: Int) -> some View {
        modifier(BadgeModifier(count: count))
    }
}

struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello")
            .modifier(BadgeModifier(count: 5))
    }
}
