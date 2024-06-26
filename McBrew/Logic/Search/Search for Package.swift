//
//  Search for Package.swift
//  McBrew
//
//  Created by alienator88 on 05.02.2023.
//

import Foundation

func searchForPackage(packageName: String, packageType: PackageType) async throws -> [String]
{
    var finalPackageArray: [String]

    switch packageType
    {
    case .formula:
        let foundFormulae = await shell(AppConstants.brewExecutablePath.absoluteString, ["search", "--formulae", packageName])

        finalPackageArray = foundFormulae.standardOutput.components(separatedBy: "\n")

    case .cask:
        let foundCasks = await shell(AppConstants.brewExecutablePath.absoluteString, ["search", "--casks", packageName])

        finalPackageArray = foundCasks.standardOutput.components(separatedBy: "\n")
    }

    finalPackageArray.removeLast()
    
    print("Search found these: \(finalPackageArray)")
    
    return finalPackageArray
}
