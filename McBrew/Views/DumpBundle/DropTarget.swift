//
//  DropTarget.swift
//  McBrew
//
//  Created by Alin Lupascu on 3/13/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct DropTarget: View {
    
    let delegate: DropDelegate
    
    let types: [UTType]

    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("drop").opacity(0.1))
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color("drop").opacity(0.4), style: StrokeStyle(lineWidth: 4, dash: [8, 4], dashPhase: 0))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onDrop(of: types, delegate: delegate)
        
    }
}
