//
//  String - Contains Element in Array.swift
//  McBrew
//
//  Created by alienator88 on 23.02.2023.
//

import Foundation

extension String {
    func containsElementFromArray(_ strings: [String]) -> Bool {
        strings.contains { contains($0) }
    }
}
