//
//  Sort Alphabetically.swift
//  McBrew
//
//  Created by alienator88 on 15.02.2023.
//

import Foundation

func sortPackagesAlphabetically(_ packageArray: [BrewPackage]) -> [BrewPackage]
{
    return packageArray.sorted{ $0.name.lowercased() < $1.name.lowercased() }
}
