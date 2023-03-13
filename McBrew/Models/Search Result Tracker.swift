//
//  Search Result Tracker.swift
//  McBrew
//
//  Created by alienator88 on 22.02.2023.
//

import Foundation

class SearchResultTracker: ObservableObject
{
    @Published var foundFormulae: [BrewPackage] = .init()
    @Published var foundCasks: [BrewPackage] = .init()
    @Published var selectedPackagesForInstallation: [String] = .init()
}
