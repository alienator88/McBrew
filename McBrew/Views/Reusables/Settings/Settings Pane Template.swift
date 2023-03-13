//
//  Settings Pane Template.swift
//  McBrew
//
//  Created by alienator88 on 13.02.2023.
//

import SwiftUI

struct SettingsPaneTemplate<Content: View>: View
{
    @ViewBuilder var paneContent: Content

    var body: some View
    {
        paneContent
            .padding()
            .frame(minWidth: 300, minHeight: 50)
            .fixedSize()
    }
}
