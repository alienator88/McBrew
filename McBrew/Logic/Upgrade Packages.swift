//
//  Upgrade Packages.swift
//  McBrew
//
//  Created by alienator88 on 04.07.2022.
//

import Foundation
import SwiftUI

@MainActor
func upgradeBrewPackages(_ updateProgressTracker: UpdateProgressTracker, appState: AppState)
{
    Task
    {
        updateProgressTracker.updateProgress = 0
        
        appState.isShowingUpdateSheet = true
        updateProgressTracker.updateStage = .updating
        updateProgressTracker.updateProgress += 0.2
        let updateResult = await shell(AppConstants.brewExecutablePath.absoluteString, ["upgrade"]).standardOutput
        updateProgressTracker.updateProgress += 0.3
        
        print("Update packages result: \(updateResult)")

//        updateProgressTracker.updateStage = .upgrading
//        updateProgressTracker.updateProgress += 0.2
//        let upgradeResult = await shell(AppConstants.brewExecutablePath.absoluteString, ["upgrade"]).standardOutput
//        updateProgressTracker.updateProgress += 0.3
//
//        print("Upgrade result: \(upgradeResult)")

        appState.isShowingUpdateSheet = false
    }
}

@MainActor
func updateBrewApp(_ updateProgressTracker: UpdateProgressTracker, appState: AppState)
{
    Task
    {
        updateProgressTracker.updateProgress = 0
        
        appState.isShowingUpdateSheet = true

        updateProgressTracker.updateStage = .upgrading
        updateProgressTracker.updateProgress += 0.2
        let upgradeResult = await shell(AppConstants.brewExecutablePath.absoluteString, ["update"]).standardOutput
        updateProgressTracker.updateProgress += 0.3
        
        print("Upgrade homebrew result: \(upgradeResult)")

        appState.isShowingUpdateSheet = false
    }
}
