//
//  Loading View.swift
//  McBrew
//
//  Created by alienator88 on 09.07.2022.
//

import SwiftUI

struct LoadingView: View
{
    var body: some View
    {
        HStack
        {
            ProgressView()
                .scaleEffect(0.5)
            Text("Loading info...")
        }
        .foregroundColor(.secondary)
    }
}
