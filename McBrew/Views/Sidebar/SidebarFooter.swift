//
//  SidebarFooter.swift
//  McBrew
//
//  Created by Alin Lupascu on 3/13/23.
//

import SwiftUI

struct SidebarFooter: View {

    @State private var isHovering = false

    var body: some View {
        VStack(spacing: 6) {
//            Text("Sidebar Footer")
//                .fontWeight(.medium)
//                .foregroundColor(Color.primary.opacity(0.6))
//            Text("You could put stuff here.")
//                .font(.footnote)
//                .foregroundColor(Color.primary.opacity(0.4))
            HStack{

                NavigationLink(destination: StartPage()) {
                    HStack{
                        Image(systemName: isHovering ? "house.fill" : "house")
                        Text("Home")
                    }
                    .padding(8)
                    .background(isHovering ? Color.gray.opacity(0.4) : Color.gray.opacity(0.2))
                    .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
                .onHover { hovering in
                            isHovering = hovering
                        }

            }
            

        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.0))
        .cornerRadius(8)
        .padding(6)
    }
}
