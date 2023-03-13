//
//  Get Pin Status.swift
//  McBrew
//
//  Created by alienator88 on 07.03.2023.
//

import Foundation
import SwiftyJSON

func getPinStatusFromJSON(json: JSON, package: BrewPackage) -> Bool
{
    if !package.isCask
    {
        return json["formulae", 0, "pinned"].boolValue
    }
    else
    {
        return json["casks", 0, "pinned"].boolValue
    }
}
