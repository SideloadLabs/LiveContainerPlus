//
//  LCDeveloperSettingsView.swift
//  LiveContainerSwiftUI
//
//  Developer options on their own pushed screen. They used to live at the very bottom of the
//  (very large) Settings form, where the toggles and buttons stopped responding on newer iOS.
//  A small dedicated Form avoids that.
//

import SwiftUI

struct LCDeveloperSettingsView: View {
    @AppStorage("LCLoadTweaksToSelf") private var injectToLCItelf = false
    @AppStorage("LCIgnoreJITOnLaunch") private var ignoreJITOnLaunch = false
    @AppStorage("LCKeepSelectedWhenQuit") private var keepSelectedWhenQuit = false
    @AppStorage("LCWaitForDebugger") private var waitForDebugger = false
    @AppStorage("LCSharePrivateDataWithLiveProcess") private var sharePrivateDataWithLiveProcess = false
    @AppStorage("BKNoWatchdogs") private var disableLiveProcessWatchdog = false

    @Binding var errorShow: Bool
    @Binding var errorInfo: String
    @Binding var successShow: Bool
    @Binding var successInfo: String

    var onExportCert: () -> Void
    var onExportDyld: () -> Void
    var onExportMainBundle: () -> Void
    var onResetSymbolOffsets: () -> Void
    var onShowFLEX: () -> Void
    var onNukeSideStore: () -> Void
    var onHide: () -> Void

    var body: some View {
        Form {
            Section {
                Toggle("lc.settings.injectLCItself".loc, isOn: $injectToLCItelf)
                Toggle("lc.settings.dev.ignoreJIT".loc, isOn: $ignoreJITOnLaunch)
                Toggle("lc.settings.dev.keepSelected".loc, isOn: $keepSelectedWhenQuit)
                Toggle("lc.settings.dev.waitForDebugger".loc, isOn: $waitForDebugger)
                Toggle("lc.settings.dev.sharePrivateData".loc, isOn: $sharePrivateDataWithLiveProcess)
                Toggle("lc.settings.dev.disableWatchdog".loc, isOn: $disableLiveProcessWatchdog)
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
        .navigationBarTitle("lc.settings.dev.title".loc)
        .alert("lc.common.error".loc, isPresented: $errorShow) {
        } message: {
            Text(errorInfo)
        }
        .alert("lc.common.success".loc, isPresented: $successShow) {
        } message: {
            Text(successInfo)
        }
    }
}
