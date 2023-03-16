//
//  Start Page.swift
//  McBrew
//
//  Created by alienator88 on 10.02.2023.
//

import SwiftUI

struct StartPage: View
{
    @AppStorage("allowBrewAnalytics") var allowBrewAnalytics: Bool = true
    
    @EnvironmentObject var brewData: BrewDataStorage
    @EnvironmentObject var availableTaps: AvailableTaps
    
    @EnvironmentObject var appState: AppState
    
    @EnvironmentObject var updateProgressTracker: UpdateProgressTracker
    
    @State private var isLoadingUpgradeablePackages = true
    @State private var upgradeablePackages: [BrewPackage] = .init()
    
    @State private var isShowingFastCacheDeletionMaintenanceView: Bool = false
    
    @State private var isDisclosureGroupExpanded: Bool = false
    
    var body: some View
    {
        VStack
        {
            if isLoadingUpgradeablePackages && appState.isRunningHealthCheck
            {
                ProgressView
                {
                    Text("Loading")
                }
            }
            else
            {
                VStack
                {
                    VStack(alignment: .center)
                    {
                        HStack
                        {
                            Text("Dashboard")
                                .font(.title)
                            
                            Spacer()
                            
                            if appState.isHealthCheckGood {
                                HStack {
                                    Image(systemName: "stethoscope")
                                        .foregroundColor(.green)
                                    Text("Homebrew is healthy")
                                }
                                .help("You're all set, nothing to do")
                            } else {
                                HStack {
                                    Image(systemName: "stethoscope")
                                        .foregroundColor(.red)
                                    Text("Homebrew is not healthy")
                                }
                                .help("Run the healthcheck from Maintenance to get more details")
                            }
                            
                        }
                        
                        
                        
                        
                        if !appState.isLoadingFormulae && !appState.isLoadingCasks && !appState.isRunningHealthCheck
                        {

                            GroupBox
                            {
//                                VStack(alignment: .leading)
//                                {
//                                    GroupBoxHeadlineGroup(
//                                        image: "terminal",
//                                        title1: "You have ",
//                                        title2: " formulae installed",
//                                        count: "\(brewData.installedFormulae.count)",
//                                        mainText: "Formulae are packages that are used via terminal"
//                                    )
//                                    .animation(.none, value: brewData.installedFormulae.count)
//
//                                    Divider()
//
//                                    GroupBoxHeadlineGroup(
//                                        image: "text.and.command.macwindow",
//                                        title1: "You have ",
//                                        title2: " \(brewData.installedCasks.count == 1 ? "cask" : "casks") installed",
//                                        count: "\(brewData.installedCasks.count)",
//                                        mainText: "Casks are packages that have graphical windows"
//                                    )
//                                    .animation(.none, value: brewData.installedCasks.count)
//
//                                    Divider()
//
//                                    GroupBoxHeadlineGroup(
//                                        image: "spigot",
//                                        title1: "You have ",
//                                        title2: " \(availableTaps.addedTaps.count == 1 ? "tap" : "taps") added",
//                                        count: "\(availableTaps.addedTaps.count)",
//                                        mainText: "Taps provide additional packages via 3rd party repositories"
//                                    )
//                                    .animation(.none, value: availableTaps.addedTaps.count)
//                                }
                            }
                            
                            if upgradeablePackages.count >= 0 // Changed from != to show the section always
                            {
                                GroupBox
                                {
                                    VStack
                                    {
                                        HStack
                                        {
//                                            GroupBoxHeadlineGroup(
//                                                image: "clock.arrow.circlepath",
//                                                title1: "You have ",
//                                                title2: " outdated \(upgradeablePackages.count == 1 ? "package" : "packages")",
//                                                count: "\(upgradeablePackages.count)",
//                                                mainText: "This shows out of date packages that should be updated"
//                                            )
                                            
                                            Spacer()
                                            
                                            if upgradeablePackages.count > 0
                                            {
                                                Button
                                                {
                                                    upgradeBrewPackages(updateProgressTracker, appState: appState)
                                                } label: {
                                                    Image(systemName: "arrow.down.app")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 18.0, height: 18.0)
                                                }
                                                .padding(.trailing)
                                                .controlSize(.large)
                                                .help("Update packages")
                                            }
                                            
                                            
                                        }
                                        
                                        HStack
                                        {
                                            
                                            if upgradeablePackages.count > 0 {
                                                DisclosureGroup(isExpanded: $isDisclosureGroupExpanded)
                                                {} label: {
                                                    Text("Outdated packages")
                                                        .font(.subheadline)
                                                    
                                                }
                                            }
                                            
                                            if isDisclosureGroupExpanded
                                            {
                                                List(upgradeablePackages)
                                                { package in
                                                    Text(package.name)
                                                }
                                                .listStyle(.bordered(alternatesRowBackgrounds: true))
                                                .frame(height: 100)
                                            }
                                            
                                        }
                                        .padding(.leading)
                                    }
                                }
                            }
                            
                            if appState.cachedDownloadsFolderSize >= 0 // changed from != so the category is visible all the time
                            {
                                GroupBox
                                {
                                    VStack
                                    {
                                        HStack
                                        {
//                                            GroupBoxHeadlineGroup(
//                                                image: "square.and.arrow.down.on.square",
//                                                title1: "You have ",
//                                                title2: " of cached downloads",
//                                                count: "\(appState.cachedDownloadsFolderSize.convertDirectorySizeToPresentableFormat(size: appState.cachedDownloadsFolderSize))",
//                                                mainText: "Leftovers from completed package installations. They're safe to remove."
//                                            )
                                            
                                            Spacer()
                                            
                                            if appState.cachedDownloadsFolderSize > 0
                                            {
                                                Button {
                                                    appState.isShowingFastCacheDeletionMaintenanceView = true
                                                } label: {
                                                    Image(systemName: "trash")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 18.0, height: 18.0)
                                                }
                                                .padding(.trailing)
                                                .controlSize(.large)
                                                .help("Delete cached downloads")
                                            }
                                            
                                            
                                            
                                        }
                                    }
                                }
                            }
                            
                            GroupBox
                            {
                                VStack(alignment: .leading)
                                {
//                                    let analyticsStatus = allowBrewAnalytics ? "ENABLED" : "DISABLED"
//                                    GroupBoxHeadlineGroupAnalytics(
//                                        image: "chart.bar",
//                                        title: "Homebrew analytics are ",
//                                        status: analyticsStatus,
//                                        mainText: "\(allowBrewAnalytics ? "Homebrew is collecting various anonymized data, such as which packages you have installed" : "Homebrew is not collecting any data about how you use it")"
//                                    )
//                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                }
                            }
                            
                            GroupBox
                            {
                                VStack(alignment: .leading)
                                {
                                    GroupBoxHeadlineGroupPaths(
                                        image: "folder",
                                        title: "Homebrew directories",
                                        info: "Right click an item from the list to navigate to the respective directory",
                                        a1: "Homebrew",
                                        a2: "\(AppConstants.brewExecutablePath)",
                                        b1: "Cellar",
                                        b2: "\(AppConstants.brewCellarPath)",
                                        c1: "Cask",
                                        c2: "\(AppConstants.brewCaskPath)",
                                        d1: "Cache",
                                        d2: "\(AppConstants.brewCachePath)"
                                    )
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    HStack
                    {
                        Spacer()
                        
                        UninstallationProgressWheel()
                    }
                }
            }
        }
        .padding()
        .onAppear
        {
            Task(priority: .high)
            {
                isLoadingUpgradeablePackages = true
                upgradeablePackages = await getListOfUpgradeablePackages()
                isLoadingUpgradeablePackages = false
            }
        }
    }
}
