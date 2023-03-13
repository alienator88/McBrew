//
//  Acknowledged Contributor.swift
//  McBrew
//
//  Created by alienator88 on 11.02.2023.
//

import Foundation

struct AcknowledgedContributor: Identifiable
{
    var id: UUID = .init()

    let name: String
    let reasonForAcknowledgement: String
    let profileService: String
    let profileURL: URL
}
