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
            if isLoadingUpgradeablePackages
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
                    VStack(alignment: .leading)
                    {
//                        Text("Current Status")
//                            .font(.title)

                        if upgradeablePackages.count != 0
                        {
                            GroupBox
                            {
                                Grid
                                {
                                    GridRow(alignment: .firstTextBaseline)
                                    {
                                        VStack(alignment: .leading)
                                        {
                                            Text(upgradeablePackages.count == 1 ? "There is 1 outdated package" : "There are \(upgradeablePackages.count) outdated packages")
                                                .font(.headline)
                                            DisclosureGroup(isExpanded: $isDisclosureGroupExpanded)
                                            {} label: {
                                                Text("Outdated packages")
                                                    .font(.subheadline)
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

                                        Button
                                        {
                                            updateBrewPackages(updateProgressTracker, appState: appState)
                                        } label: {
                                            Text("Update")
                                        }
                                    }
                                }
                            }
                        }

                        if !appState.isLoadingFormulae && !appState.isLoadingCasks
                        {
                            Text("Dashboard")
                                .font(.title2)
                            
                            GroupBox
                            {
                                VStack(alignment: .leading)
                                {
                                    GroupBoxHeadlineGroup(
                                        image: "terminal",
                                        title1: "You have ",
                                        title2: " formulae installed",
                                        count: "\(brewData.installedFormulae.count)",
                                        mainText: "Formulae are packages that are used via terminal"
                                    )
                                    .animation(.none, value: brewData.installedFormulae.count)

                                    Divider()

                                    GroupBoxHeadlineGroup(
                                        image: "text.and.command.macwindow",
                                        title1: "You have ",
                                        title2: " \(brewData.installedCasks.count == 1 ? "cask" : "casks") installed",
                                        count: "\(brewData.installedCasks.count)",
                                        mainText: "Casks are packages that have graphical windows"
                                    )
                                    .animation(.none, value: brewData.installedCasks.count)

                                    Divider()

                                    GroupBoxHeadlineGroup(
                                        image: "spigot",
                                        title1: "You have ",
                                        title2: " \(availableTaps.addedTaps.count == 1 ? "tap" : "taps") added",
                                        count: "\(availableTaps.addedTaps.count)",
                                        mainText: "Taps provide additional packages via 3rd party repositories"
                                    )
                                    .animation(.none, value: availableTaps.addedTaps.count)
                                }
                            }
                            
                            GroupBox
                            {
                                VStack(alignment: .leading)
                                {
                                    let analyticsStatus = allowBrewAnalytics ? "ENABLED" : "DISABLED"
                                    GroupBoxHeadlineGroupAnalytics(
                                        image: "chart.bar",
                                        title: "Homebrew analytics are ",
                                        status: analyticsStatus,
                                        mainText: "\(allowBrewAnalytics ? "Homebrew is collecting various anonymized data, such as which packages you have installed" : "Homebrew is not collecting any data about how you use it")"
                                    )
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                }
                            }
                            
                            GroupBox
                            {
                                VStack(alignment: .leading)
                                {
                                    GroupBoxHeadlineGroupPaths(
                                        image: "folder",
                                        title: "Homebrew installation paths",
                                        a1: "Brew: ",
                                        a2: "\(AppConstants.brewExecutablePath)",
                                        b1: "Cellar: ",
                                        b2: "\(AppConstants.brewCellarPath)",
                                        c1: "Cask: ",
                                        c2: "\(AppConstants.brewCaskPath)",
                                        d1: "Cache: ",
                                        d2: "\(AppConstants.brewCachePath)"
                                    )
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                }
                            }
                            
                            if appState.cachedDownloadsFolderSize != 0
                            {
                                GroupBox
                                {
                                    VStack
                                    {
                                        HStack
                                        {
                                            GroupBoxHeadlineGroup(
                                                image: "square.and.arrow.down.on.square",
                                                title1: "You have ",
                                                title2: " of cached downloads",
                                                count: "\(appState.cachedDownloadsFolderSize.convertDirectorySizeToPresentableFormat(size: appState.cachedDownloadsFolderSize))",
                                                mainText: "These files are leftovers from completed package installations. They're safe to remove."
                                            )

                                            Spacer()

                                            Button {
                                                appState.isShowingFastCacheDeletionMaintenanceView = true
                                            } label: {
                                                Image(systemName: "trash")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 18.0, height: 18.0)
                                                
//                                                Text("Empty Download Cache")
                                            }
                                            .padding(.trailing)
                                            .controlSize(.large)
                                        }
                                    }
                                }
                            }
                            
                        }
                    }

                    Spacer()

                    HStack
                    {
                        Spacer()
                        
                        UninstallationProgressWheel()

//                        Button
//                        {
//                            print("Would perform maintenance")
//                            appState.isShowingMaintenanceSheet.toggle()
//                        } label: {
//                            Text("Maintenance")
//                        }
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
