//
//  Update Progress Tracker.swift
//  McBrew
//
//  Created by David Bureš on 04.07.2022.
//

import Foundation
import SwiftUI

enum UpdateStages: String
{
    case notDoingAnything = ""
    case updating = "Updating packages"
    case upgrading = "Upgrading homebrew"
}

class UpdateProgressTracker: ObservableObject
{
    @Published var updateProgress: Float = 0
    @Published var updateStage: UpdateStages = .notDoingAnything
}
