//
//  Used Package.swift
//  McBrew
//
//  Created by alienator88 on 11.02.2023.
//

import Foundation

struct UsedPackage: Identifiable
{
    var id: UUID = .init()

    let name: String
    let whyIsItUsed: String
    let packageURL: URL
}

