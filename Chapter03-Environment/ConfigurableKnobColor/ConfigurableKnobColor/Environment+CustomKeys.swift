//
//  Environment+CustomKeys.swift
//  ConfigurableKnobColor
//
//  Created by Domagoj Eklic on 1/7/22.
//

import SwiftUI

// MARK: KnobColor

struct KnobColorKey: EnvironmentKey {
    static var defaultValue: Color {
        .black
    }
}

extension EnvironmentValues {
    var knobColor: Color {
        get {
            self[KnobColorKey.self]
        }
        set {
            self[KnobColorKey.self] = newValue
        }
    }
}

extension View {
    func knobColor(_ color: Color) -> some View {
        environment(\.knobColor, color)
    }
}

// MARK: KnobPointerSize

struct KnobPointerSizeKey: EnvironmentKey {
    static var defaultValue = CGFloat(0.1)
}

extension EnvironmentValues {
    var knobPointerSize: CGFloat {
        get {
            self[KnobPointerSizeKey.self]
        }
        set {
            self[KnobPointerSizeKey.self] = newValue
        }
    }
}

extension View {
    func knobPointerSize(_ size: CGFloat) -> some View {
        environment(\.knobPointerSize, size)
    }
}
