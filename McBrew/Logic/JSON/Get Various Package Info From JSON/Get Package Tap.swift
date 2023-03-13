//
//  Get Package Tap.swift
//  McBrew
//
//  Created by alienator88 on 27.02.2023.
//

import Foundation
import SwiftyJSON

func getPackageTapFromJSON(json: JSON, package: BrewPackage) -> String
{
    if !package.isCask
    {
        return json["formulae", 0, "tap"].stringValue
    }
    else
    {
        return json["casks", 0, "tap"].stringValue
    }
}
