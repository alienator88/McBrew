//
//  Package List Item.swift
//  McBrew
//
//  Created by David Bureš on 03.07.2022.
//

import SwiftUI

struct PackageListItem: View
{
    var packageItem: BrewPackage

    var body: some View
    {
        HStack
        {
            HStack(alignment: .firstTextBaseline, spacing: 5)
            {
                Image(systemName: "shippingbox")
                Text(packageItem.name)
                Text("v\(returnFormattedVersions(packageItem.versions))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
