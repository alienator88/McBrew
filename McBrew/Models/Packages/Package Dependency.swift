//
//  Package Dependency.swift
//  McBrew
//
//  Created by alienator88 on 27.02.2023.
//

import Foundation

struct BrewPackageDependency: Identifiable
{
    let id: UUID = UUID()
    let name: String
    let version: String
    let directlyDeclared: Bool
}
