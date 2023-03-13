//
//  Dismiss Sheet Button.swift
//  McBrew
//
//  Created by alienator88 on 12.02.2023.
//

import SwiftUI

struct DismissSheetButton: View
{
    @Binding var isShowingSheet: Bool

    var body: some View
    {
        Button
        {
            isShowingSheet.toggle()
        } label: {
            Text("Cancel")
        }
        .keyboardShortcut(.cancelAction)
    }
}
