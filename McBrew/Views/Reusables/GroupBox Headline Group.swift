//
//  GroupBox Headline Group.swift
//  McBrew
//
//  Created by alienator88 on 10.02.2023.
//

import SwiftUI

struct GroupBoxHeadlineGroup: View
{
    @Environment(\.colorScheme) var colorScheme
    let title: String
    let mainText: String
    
    var body: some View
    {
        HStack(spacing: 15)
        {
            
            VStack(alignment: .center, spacing: 2)
            {
                
                HStack(spacing: 0) {
                    Text(title)
                }
                
                
                Text(mainText)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
        }
        .padding(10)
        .foregroundStyle(colorScheme == .dark ?
                         LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                         )
                         : LinearGradient(
                            colors: [Color("drop")],
                            startPoint: .leading,
                            endPoint: .trailing
                         )
        )
    }
}

struct GroupBoxHeadlineGroupAnalytics: View
{
    @Environment(\.colorScheme) var colorScheme
    let title: String
    let mainText: String
    
    var body: some View
    {
        HStack(spacing: 15)
        {
            
            VStack(alignment: .center, spacing: 2)
            {
                HStack(spacing: 0) {
                    Text(title)
                }
                Text(mainText)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(10)
        .foregroundStyle(colorScheme == .dark ?
                         LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                         )
                         : LinearGradient(
                            colors: [Color("drop")],
                            startPoint: .leading,
                            endPoint: .trailing
                         )
        )
    }
}



struct PathStruct: Identifiable {
    let folder: String
    let path: String
    let id = UUID()
}

struct GroupBoxHeadlineGroupPaths: View
{
    var image: String?
    let title: String
    let info: String
    let a1: String
    let a2: String
    let b1: String
    let b2: String
    let c1: String
    let c2: String
    let d1: String
    let d2: String
    
    var body: some View
    {
        
        HStack(spacing: 15)
        {
            
            if let image
            {
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 26, height: 26)
            }
            
            VStack(alignment: .leading, spacing: 2)
            {
                HStack(spacing: 0) {
                    Text(title)
                }
                Text(info)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            
        }
        .padding(10)
        
        HStack {
            
            let allPaths = [
                PathStruct(folder: a1, path: a2),
                PathStruct(folder: b1, path: b2),
                PathStruct(folder: c1, path: c2),
                PathStruct(folder: d1, path: d2),
            ]
            
            Table(allPaths) {
                TableColumn("Item") { item in
                    Text(item.folder).contextMenu {
                        Button
                        {
                            if item.folder.contains("Homebrew") {
                                let url = URL(filePath: item.path)
                                let newPath = url.deletingLastPathComponent()
                                NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: newPath.path)
                            } else {
                                NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: item.path)
                            }
                            
                        } label: {
                            Text("Open \(item.folder) path")
                        }
                    }
                }.width(100)
                TableColumn("Path") { item in
                    Text(item.path).contextMenu {
                        Button
                        {
                            if item.folder.contains("Homebrew") {
                                let url = URL(filePath: item.path)
                                let newPath = url.deletingLastPathComponent()
                                NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: newPath.path)
                            } else {
                                NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: item.path)
                            }
                        } label: {
                            Text("Open \(item.folder) path")
                        }
                    }
                }
                
            }
            .frame(height: 140)
            
        }
        
    }
}


