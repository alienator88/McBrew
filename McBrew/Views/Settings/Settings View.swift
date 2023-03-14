//
//  Settings View.swift
//  McBrew
//
//  Created by alienator88 on 13.02.2023.
//

import SwiftUI

struct SettingsView: View
{    
    var body: some View
    {
        TabView()
        {
            GeneralPane()
                .tabItem
                {
                    Label("General", systemImage: "gearshape")
                }
                .tag(1)
            
            MaintenancePane()
                .tabItem
                {
                    Label("Maintenance", systemImage: "arrow.3.trianglepath")
                }
                .tag(2)

            BrewPane()
                .tabItem {
                    Label("Homebrew", systemImage: "cup.and.saucer")
                }
                .tag(3)

            DropPane()
                .tabItem {
                    Label("Brewfile", systemImage: "arrow.down.app")
                }
                .tag(4)

                        AboutView()
                            .tabItem
                            {
                                Label("About", systemImage: "info.circle")
                            }
                            .tag(5)
//            InstallationAndUninstallationPane()
//                .tabItem
//                {
//                    Label("Install and Uninstall", systemImage: "plus")
//                }
//                .tag(5)
        }
        .frame(minWidth: 550)
    }
}
