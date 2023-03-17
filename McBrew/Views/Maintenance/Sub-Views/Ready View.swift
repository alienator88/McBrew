//
//  Ready View.swift
//  McBrew
//
//  Created by alienator88 on 25.02.2023.
//

import SwiftUI

struct MaintenanceReadyView: View {
    
    @AppStorage("default_shouldUninstallOrphans") var default_shouldUninstallOrphans: Bool = true
    @AppStorage("default_shouldPurgeCache") var default_shouldPurgeCache: Bool = true
    @AppStorage("default_shouldDeleteDownloads") var default_shouldDeleteDownloads: Bool = true
    @AppStorage("default_shouldPerformHealthCheck") var default_shouldPerformHealthCheck: Bool = false
    
    @Binding var shouldUninstallOrphans: Bool
    @Binding var shouldPurgeCache: Bool
    @Binding var shouldDeleteDownloads: Bool
    @Binding var shouldPerformHealthCheck: Bool
    
    @Binding var isShowingSheet: Bool
    
    @Binding var maintenanceSteps: MaintenanceSteps
    
    @State var isShowingControlButtons: Bool
    
    @State var forcedOptions: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10)
        {
            //            Form
            //            {
            
            VStack(alignment: .center) {
                HStack{
                    Text("Uninstall orphaned packages")
                    Spacer()
                    Toggle(isOn: $shouldUninstallOrphans)
                    {
                    }
                    .toggleStyle(.switch)
                }
                
                
                HStack{
                    Text("Purge Homebrew cache")
                    Spacer()
                    Toggle(isOn: $shouldPurgeCache)
                    {
                    }
                    .toggleStyle(.switch)
                }
                
                
                HStack{
                    Text("Empty Download Cache")
                    Spacer()
                    Toggle(isOn: $shouldDeleteDownloads)
                    {
                    }
                    .toggleStyle(.switch)
                }
                
                
                HStack{
                    Text("Perform health check")
                    Spacer()
                    Toggle(isOn: $shouldPerformHealthCheck)
                    {
                    }
                    .toggleStyle(.switch)
                }
                 
            }
            
            
            if isShowingControlButtons
            {
                HStack
                {
                    DismissSheetButton(isShowingSheet: $isShowingSheet)
                    
                    Spacer()
                    
                    Button
                    {
                        print("Start")
                        maintenanceSteps = .maintenanceRunning
                    } label: {
                        Text("Start")
                    }
                    .keyboardShortcut(.defaultAction)
                    .disabled(isStartDisabled)
                }
                .padding(.top)
            }
        }
        .onAppear
        {
            if !forcedOptions
            {
                /// Replace the provided values with those from AppStorage
                /// I have to do this because I don't want the settings in the sheet itself to affect those in the defaults
                shouldUninstallOrphans = default_shouldUninstallOrphans
                shouldPurgeCache = default_shouldPurgeCache
                shouldDeleteDownloads = default_shouldDeleteDownloads
                shouldPerformHealthCheck = default_shouldPerformHealthCheck
            }
            
        }
    }
    
    private var isStartDisabled: Bool {
        [shouldUninstallOrphans, shouldPurgeCache, shouldDeleteDownloads, shouldPerformHealthCheck].allSatisfy { !$0 }
    }
}
