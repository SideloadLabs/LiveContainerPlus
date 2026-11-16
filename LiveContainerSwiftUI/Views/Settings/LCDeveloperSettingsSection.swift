//
//  LCDeveloperSettingsSection.swift
//  LiveContainerSwiftUI
//
//  Developer settings, extracted from LCSettingsView so the (already very large)
//  settings Form body stays small and each control binds directly to its setting.
//

import SwiftUI

struct LCDeveloperSettingsSection: View {
    @AppStorage("LCLoadTweaksToSelf") private var injectToLCItself = false
    @AppStorage("LCIgnoreJITOnLaunch") private var ignoreJITOnLaunch = false
    @AppStorage("LCKeepSelectedWhenQuit") private var keepSelectedWhenQuit = false
    @AppStorage("LCWaitForDebugger") private var waitForDebugger = false
    @AppStorage("LCSharePrivateDataWithLiveProcess") private var sharePrivateDataWithLiveProcess = false
    @AppStorage("BKNoWatchdogs") private var disableLiveProcessWatchdog = false

    let onExportCert: () -> Void
    let onExportDyld: () -> Void
    let onNukeSideStore: () -> Void
    let onExportMainBundle: () -> Void
    let onResetSymbolOffsets: () -> Void
    let onShowFLEX: () -> Void
    let onHide: () -> Void

    var body: some View {
        Group {
            Section {
                Toggle("lc.settings.injectLCItself".loc, isOn: $injectToLCItself)
                Toggle("lc.settings.dev.ignoreJIT".loc, isOn: $ignoreJITOnLaunch)
                Toggle("lc.settings.dev.keepSelected".loc, isOn: $keepSelectedWhenQuit)
                Toggle("lc.settings.dev.waitForDebugger".loc, isOn: $waitForDebugger)
                Toggle("lc.settings.dev.sharePrivateData".loc, isOn: $sharePrivateDataWithLiveProcess)
                Toggle("lc.settings.dev.disableWatchdog".loc, isOn: $disableLiveProcessWatchdog)
            } header: {
                Text("lc.settings.dev.title".loc)
            } footer: {
                Text("lc.settings.injectLCItselfDesc".loc)
            }

            Section {
                Button("lc.settings.dev.exportCert".loc, action: onExportCert)
                Button("lc.settings.dev.exportDyld".loc, action: onExportDyld)
                Button("lc.settings.dev.exportMainBundle".loc, action: onExportMainBundle)
                Button("lc.settings.dev.resetSymbolOffsets".loc, action: onResetSymbolOffsets)
                Button("lc.settings.dev.showFLEX".loc, action: onShowFLEX)
                    .disabled(NSClassFromString("FLEXManager") == nil)
                Button("lc.settings.dev.nukeSideStore".loc, role: .destructive, action: onNukeSideStore)
            }

            Section {
                Button("lc.settings.dev.hide".loc, action: onHide)
            }
        }
    }
}
