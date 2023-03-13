//
//  Sort by Install Date.swift
//  McBrew
//
//  Created by David Bureš on 15.02.2023.
//

import Foundation

func sortPackagesByInstallDate( _ packageArray: [BrewPackage]) -> [BrewPackage]
{
    return packageArray.sorted{ $0.installedOn ?? Date() < $1.installedOn ?? Date() }
}
