//
//  Update Progress Tracker.swift
//  McBrew
//
//  Created by alienator88 on 04.07.2022.
//

import Foundation
import SwiftUI

enum UpdateStages: String
{
    case notDoingAnything = ""
    case updating = "Updating packages"
    case upgrading = "Upgrading homebrew"
    case brewfile = "installing packages from Brewfile"
}

class UpdateProgressTracker: ObservableObject
{
    @Published var updateProgress: Float = 0
    @Published var updateStage: UpdateStages = .notDoingAnything
}
