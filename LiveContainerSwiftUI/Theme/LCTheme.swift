//
//  LCTheme.swift
//  LiveContainerSwiftUI
//
//  LiveContainer Extended — Theme, accent, app layout
//

import SwiftUI
import UIKit
import Combine

// MARK: - App layout

enum LCAppLayoutMode: String, CaseIterable, Identifiable {
    case list = "List"
    case grid = "Grid"
    case compact = "Compact"
    case springboard = "SpringBoard"
    
    var id: String { rawValue }
    
    var systemImage: String {
        switch self {
        case .list: return "list.bullet"
        case .grid: return "square.grid.2x2"
        case .compact: return "list.bullet.rectangle"
        case .springboard: return "square.grid.3x3.fill"
        }
    }
}

// MARK: - Theme (live-updating)

final class LCTheme: ObservableObject {
    static let shared = LCTheme()
    
    private let defaults: UserDefaults = LCUtils.appGroupUserDefault
    
    @Published var doubleTapStatusBarToExit: Bool {
        didSet {
            defaults.set(doubleTapStatusBarToExit, forKey: "LCDoubleTapStatusBarToExit")
        }
    }
    
    @Published var appLayout: LCAppLayoutMode {
        didSet {
            defaults.set(appLayout.rawValue, forKey: "LCAppLayoutMode")
            objectWillChange.send()
        }
    }
    
    /// The app's original accent colour (AccentColor asset) — no custom accent presets.
    var accent: Color { Color.accentColor }
    
    var pageBackground: Color {
        Color(UIColor { t in
            t.userInterfaceStyle == .dark
                ? UIColor(red: 0.07, green: 0.07, blue: 0.09, alpha: 1)
                : UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1)
        })
    }
    
    var cardBackground: Color {
        Color(UIColor { t in
            t.userInterfaceStyle == .dark
                ? UIColor(red: 0.12, green: 0.13, blue: 0.15, alpha: 1)
                : UIColor.white
        })
    }
    
    var cardBorder: Color {
        Color(UIColor { t in
            t.userInterfaceStyle == .dark
                ? UIColor(white: 1, alpha: 0.08)
                : UIColor(white: 0, alpha: 0.06)
        })
    }
    
    var secondaryText: Color { Color(UIColor.secondaryLabel) }
    var success: Color { Color(red: 0.18, green: 0.72, blue: 0.40) }
    var warning: Color { Color(red: 0.95, green: 0.65, blue: 0.15) }
    var danger:  Color { Color(red: 0.92, green: 0.28, blue: 0.28) }
    
    private init() {
        if defaults.object(forKey: "LCDoubleTapStatusBarToExit") == nil {
            self.doubleTapStatusBarToExit = true
        } else {
            self.doubleTapStatusBarToExit = defaults.bool(forKey: "LCDoubleTapStatusBarToExit")
        }
        
        let layoutRaw = defaults.string(forKey: "LCAppLayoutMode") ?? LCAppLayoutMode.list.rawValue
        self.appLayout = LCAppLayoutMode(rawValue: layoutRaw) ?? .list
    }
    
}

// MARK: - Modifiers

struct LCCardModifier: ViewModifier {
    @ObservedObject private var theme = LCTheme.shared
    var radius: CGFloat = 16
    
    func body(content: Content) -> some View {
        content
            .background(theme.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .stroke(theme.cardBorder, lineWidth: 1)
            )
    }
}

extension View {
    func lcThemeCard(radius: CGFloat = 16) -> some View {
        modifier(LCCardModifier(radius: radius))
    }
}
