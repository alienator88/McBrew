//
//  SwiftUIView.swift
//  McBrew
//
//  Created by alienator88 on 12.02.2023.
//

import SwiftUI

struct SheetWithTitle<Content: View>: View
{
    @State var title: String

    @ViewBuilder var sheetContent: Content

    var body: some View
    {
        VStack(alignment: .center)
        {
            Text(title)
                .font(.title2)

            sheetContent
        }
        .frame(minWidth: 250)
    }
}
