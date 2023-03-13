//
//  Uninstallation Progress Wheel.swift
//  McBrew
//
//  Created by alienator88 on 20.02.2023.
//

import SwiftUI

struct UninstallationProgressWheel: View
{
    @EnvironmentObject var appState: AppState

    var body: some View
    {
        if appState.isShowingUninstallationProgressView
        {
            ProgressView()
                .scaleEffect(0.5, anchor: .center)
                .frame(width: 1, height: 1)
        }
    }
}
