//
//  DropFile Pane.swift
//  McBrew
//
//  Created by Alin Lupascu on 3/13/23.
//

import SwiftUI
import UniformTypeIdentifiers

private let dropTypes = [UTType.fileURL]
let dialog = NSOpenPanel();


struct DropPane: View
{
    @StateObject var pview = UpdateProgressTracker()
    
    var body: some View
    {
        
        VStack{
            
            // Drop Target
            DropTarget(delegate: self, types: dropTypes)
                .frame(width: 400, height: 250)
                .overlay(dropOverlay, alignment: .center)
                .padding()
            
            // Add brewfile button
            Button
            {
                bundleDump()
            } label: {
                Label
                {
                    Text("Create New Brewfile")
                } icon: {
                    Image(systemName: "plus")
                    
                }
            }
            Text("Dump all packages as a bundle for backup purposes")
                .font(.footnote)
                .foregroundColor(Color("drop").opacity(0.6))
                .padding(.bottom)
        }
        
    }
    
    @ViewBuilder private var dropOverlay: some View {
        if pview.showProgressView {
            HStack {
                ProgressView().padding(.trailing)
                Text("Installing packages..").foregroundColor(Color("drop")).opacity(0.5).font(.callout)
            }
        } else {
            Text("Drop Brewfile here to install packages").foregroundColor(Color("drop")).opacity(0.5).font(.callout)
        }
    }
    
}

// Drop Delegate
extension DropPane: DropDelegate {
    
    func performDrop(info: DropInfo) -> Bool {
        
        let itemProviders = info.itemProviders(for: [UTType.fileURL])
        
        guard itemProviders.count == 1 else {
            return false
        }
        for itemProvider in itemProviders {
            itemProvider.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { item, error in
                guard let data = item as? Data else {
                    dump(error)
                    return
                }
                guard let url = URL(dataRepresentation: data, relativeTo: nil) else {
                    print("Error: Not a valid URL.")
                    return
                }
                Task
                {
                    pview.showProgressView = true
                    
                    let bundleResult = await shell(AppConstants.brewExecutablePath.absoluteString, ["bundle", "install", "--file=\(url.path)"]).standardOutput
                    
                    print("Bundle result: \(bundleResult)")
                    
                    pview.showProgressView = false
                    
                }
                
                print("File was dropped: \(url.path)")
                
            }
        }
        
        return true
    }
}

@MainActor
func bundleDump()
{
    dialog.title                   = "Choose a folder where you'd like to dump your Brewfile";
    dialog.showsResizeIndicator    = true;
    dialog.showsHiddenFiles        = false;
    dialog.canChooseFiles = false;
    dialog.canChooseDirectories = true;
    
    if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
        let result = dialog.url
        
        if (result != nil) {
            let path: String = result!.path
            
            Task
            {
                
                let dumpResult = await shell(AppConstants.brewExecutablePath.absoluteString, ["bundle", "dump", "--file=\(path)/Brewfile", "--force"]).standardOutput
                
                print("Dump bundle result: \(dumpResult)\nBrewfile created at \(path)/Brewfile")
                
            }
        }
    } else {
        return
    }
}


