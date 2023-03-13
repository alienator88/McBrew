//
//  Package Sorting.swift
//  McBrew
//
//  Created by alienator88 on 15.02.2023.
//

import Foundation

enum PackageSortingOptions: String, Codable, CaseIterable
{
    case none, alphabetically, byInstallDate, bySize
}
