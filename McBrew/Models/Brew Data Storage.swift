//
//  Brew Data Storage.swift
//  McBrew
//
//  Created by alienator88 on 03.07.2022.
//

import Foundation

@MainActor
class BrewDataStorage: ObservableObject
{
    @Published var installedFormulae = [BrewPackage]()
    @Published var installedCasks = [BrewPackage]()
}

class AvailableTaps: ObservableObject
{
    @Published var addedTaps = [BrewTap]()
}
