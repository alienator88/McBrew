//
//  AppDelegate.swift
//  McBrew
//
//  Created by alienator88 on 07.07.2022.
//

import Foundation
import AppKit
import SwiftUI
import DavidFoundation

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    private var aboutWindowController: NSWindowController?
    
    func showAboutPanel()
    {
        if aboutWindowController == nil
        {
            let styleMask: NSWindow.StyleMask = [.closable, .titled, .unifiedTitleAndToolbar]
            let window = NSWindow()

            window.styleMask = styleMask
            window.title = "About \(NSApplication.appName!)"
            window.contentView = NSHostingView(rootView: AboutView())
            window.titleVisibility = .hidden
            window.titlebarAppearsTransparent = true

            aboutWindowController = NSWindowController(window: window)
        }
        aboutWindowController?.window?.center()
        aboutWindowController?.showWindow(aboutWindowController?.window)
    }
}
