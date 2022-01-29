//
//  ContentView.swift
//  SwiftUILayout
//
//  Created by Domagoj Eklic on 1/27/22.
//

import SwiftUI

struct CollapsibleHStack<Element, Content: View>: View {
    var data: [Element]
    var expanded: Bool = true
    var spacing: CGFloat = 18
    var collapsedWidth: CGFloat = 10
    var alignment: VerticalAlignment = .top

    var content: (Element) -> Content

    private func child(atIndex index: Int) -> some View {
        let isExpanded = expanded ||
                         data.endIndex - 1 == index // Last element is always expanded

        let element = data[index]

        // Child won't be clipped in the collapsed state
        // It'll be rendered as its size is equal to collapsedWidth
        return content(element)
                    .frame(width: isExpanded ? nil : collapsedWidth,
                           alignment: Alignment(horizontal: .leading, vertical: alignment))
    }

    var body: some View {
        HStack(alignment: alignment, spacing: spacing) {
            ForEach(data.indices) { index in
                child(atIndex: index)
            }
        }
        .border(Color(UIColor.red))
    }
}

// Define test model data
struct RectModel {
    let width: CGFloat
    let height: CGFloat

    let fillColor: UIColor

    static let testData: [RectModel] = [
        RectModel(width: 100, height: 100, fillColor: .black),
        RectModel(width: 50, height: 50, fillColor: .green),
        RectModel(width: 200, height: 200, fillColor: .yellow),
    ]
}

// Define test view
// It contains CollapsibleHStack and button that performs stack toggling
struct TestView: View {

    @State
    var expanded: Bool = true

    var body: some View {
        VStack {
            CollapsibleHStack(data: RectModel.testData, expanded: expanded) { model in
                Rectangle()
                    .fill(Color(model.fillColor))
                    .frame(width: model.width, height: model.height)
            }
            Button(action: { withAnimation(.default) {
                expanded.toggle()
            }}, label: {
                Text("Toggle")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
