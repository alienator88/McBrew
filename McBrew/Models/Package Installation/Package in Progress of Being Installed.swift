//
//  Package in Progress of Being Installed.swift
//  McBrew
//
//  Created by alienator88 on 22.02.2023.
//

import Foundation

struct PackageInProgressOfBeingInstalled: Identifiable
{
    let id = UUID()
    
    let package: BrewPackage
    var installationStage: PackageInstallationStage
    var packageInstallationProgress: Double
    
    var realTimeTerminalOutput: String?
}
