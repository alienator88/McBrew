//
//  Complex with Icon.swift
//  McBrew
//
//  Created by alienator88 on 13.02.2023.
//

import SwiftUI

struct ComplexWithIcon<Content: View>: View
{
    @State var systemName: String

    @ViewBuilder var content: Content

    var body: some View
    {
        HStack(alignment: .top, spacing: 10)
        {
            Image(systemName: systemName)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.secondary)
                .padding()

            content
        }
    }
}
