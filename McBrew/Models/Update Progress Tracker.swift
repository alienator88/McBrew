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
    case updating = "Updating Packages"
    case upgrading = "Upgrading Homebrew"
    case brewfile = "Installing Brewfile packages"
}

class UpdateProgressTracker: ObservableObject
{
    @Published var updateProgress: Float = 0
    @Published var updateStage: UpdateStages = .notDoingAnything
    @Published var showProgressView: Bool = false
}
