//
//  Bundle.swift
//  McBrew
//
//  Created by Alin Lupascu on 3/13/23.
//

import Foundation
import SwiftUI

let dialog = NSOpenPanel();


@MainActor
func bundleDump()
{
    dialog.title                   = "Choose a folder where you'd like to dump your Brewfile";
    dialog.showsResizeIndicator    = true;
    dialog.showsHiddenFiles        = false;
    dialog.canChooseFiles = false;
    dialog.canChooseDirectories = true;

    if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
        let result = dialog.url

        if (result != nil) {
            let path: String = result!.path
            Task
            {
                let dumpResult = await shell(AppConstants.brewExecutablePath.absoluteString, ["bundle", "dump", "--file=\(path)/Brewfile", "--force"]).standardOutput
                print("Dump bundle result: \(dumpResult)\nBrewfile created at \(path)/Brewfile")
            }
        }
    } else {
        return
    }
}



@MainActor
func bundleFile(_ updateProgressTracker: UpdateProgressTracker, appState: AppState)
{
    dialog.title                   = "Choose a Brewfile to install packages and configurations";
    dialog.showsResizeIndicator    = true;
    dialog.showsHiddenFiles        = false;
    dialog.canChooseFiles = true;
    dialog.canChooseDirectories = false;

    if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
        let result = dialog.url

        if (result != nil) {
            let path: String = result!.path
            Task
            {
                updateProgressTracker.updateProgress = 0
                
                appState.isShowingUpdateSheet = true
                updateProgressTracker.updateStage = .updating
                updateProgressTracker.updateProgress += 0.2
                
                let bundleResult = await shell(AppConstants.brewExecutablePath.absoluteString, ["bundle", "install", "--file=\(path)"]).standardOutput
                updateProgressTracker.updateProgress += 0.3
                print("Bundle result: \(bundleResult)")
                
                appState.isShowingUpdateSheet = false

            }
        }
    } else {
        return
    }
}
