//
//  Sidebar View.swift
//  McBrew
//
//  Created by alienator88 on 14.02.2023.
//

import SwiftUI

struct SidebarView: View
{
    @EnvironmentObject var brewData: BrewDataStorage
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var availableTaps: AvailableTaps

    @EnvironmentObject var selectedPackageInfo: SelectedPackageInfo

    @State private var isShowingSearchField: Bool = false
    @State private var searchText: String = ""
    @State private var isHovering = false
    

    var body: some View
    {
        List
        {
            Section("Formulae (\(brewData.installedFormulae.count))")
            {
                if !appState.isLoadingFormulae
                {
                    ForEach(searchText.isEmpty ? brewData.installedFormulae : brewData.installedFormulae.filter { $0.name.contains(searchText) })
                    { formula in
                        NavigationLink
                        {
                            PackageDetailView(package: formula, packageInfo: selectedPackageInfo)
                        } label: {
                            PackageListItem(packageItem: formula)
                        }
                        .contextMenu
                        {
                            Button
                            {
                                Task
                                {
                                    try await uninstallSelectedPackage(package: formula, brewData: brewData, appState: appState)
                                }
                            } label: {
                                Text("Uninstall \(formula.name)")
                            }
                        }
                    }
                }
                else
                {
                    Text("No formulae found")
//                    ProgressView()
                }
            }
            .collapsible(true)
            .font(.system(size: 14))

            Section("Casks (\(brewData.installedCasks.count))")
            {
                if !appState.isLoadingCasks
                {
                    ForEach(searchText.isEmpty ? brewData.installedCasks : brewData.installedCasks.filter { $0.name.contains(searchText) })
                    { cask in
                        NavigationLink
                        {
                            PackageDetailView(package: cask, packageInfo: selectedPackageInfo)
                        } label: {
                            PackageListItem(packageItem: cask)
                        }
                        .contextMenu
                        {
                            Button
                            {
                                Task
                                {
                                    try await uninstallSelectedPackage(package: cask, brewData: brewData, appState: appState)
                                }
                            } label: {
                                Text("Uninstall \(cask.name)")
                            }
                        }
                    }
                }
                else
                {
                    Text("No casks found")
//                    ProgressView()
                }
            }
            .collapsible(true)
            .font(.system(size: 14))


            if searchText.isEmpty
            {
                Section("Taps (\(availableTaps.addedTaps.count))")
                {
                    if availableTaps.addedTaps.count != 0
                    {
                        ForEach(availableTaps.addedTaps)
                        { tap in
                            HStack(alignment: .center, spacing: 5){
                                Image(systemName: "spigot")
                                Text(tap.name)
                            }
                                .contextMenu
                                {
                                    Button
                                    {
                                        Task(priority: .userInitiated)
                                        {
                                            print("Would remove \(tap.name)")
                                            try await removeTap(name: tap.name, availableTaps: availableTaps, appState: appState)
                                        }
                                    } label: {
                                        Text("Remove \(tap.name)")
                                    }
                                    .alert(isPresented: $appState.isShowingRemoveTapFailedAlert, content: {
                                        Alert(title: Text("Couldn't remove \(tap.name)"), message: Text("Try again in a few minutes, or restart McBrew"), dismissButton: .default(Text("Close"), action: {
                                            appState.isShowingRemoveTapFailedAlert = false
                                        }))
                                    })
                                }
                        }
                    }
                    else
                    {
                        Text("No taps found")
//                        ProgressView()
                    }
                }
                .collapsible(true)
                .font(.system(size: 14))

            }
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 250)
        .safeAreaInset(edge: .bottom, spacing: 0) {
                    SidebarFooter()
                }
        .searchable(text: $searchText, placement: .automatic, prompt: Text("Search"))
        .sheet(isPresented: $appState.isShowingMaintenanceSheet)
        {
            MaintenanceView(isShowingSheet: $appState.isShowingMaintenanceSheet)
        }
        .sheet(isPresented: $appState.isShowingFastCacheDeletionMaintenanceView)
        {
            MaintenanceView(isShowingSheet: $appState.isShowingFastCacheDeletionMaintenanceView, shouldPurgeCache: false, shouldUninstallOrphans: false, shouldPerformHealthCheck: false, forcedOptions: true)
        }
        .toolbar {
            
//            ToolbarItem {
//                Text("McBrew")
//            }
            
            ToolbarItem {
                            Button(action: toggleSidebar, label: {
                                Image(systemName: "sidebar.leading")
                            })
            }            
        }
    }
}
