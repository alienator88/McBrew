//
//  StartDashboard.swift
//  McBrew
//
//  Created by Alin Lupascu on 3/15/23.
//

import SwiftUI

struct StartDash: View
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
    @State private var showingAlert = false
    
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
                            
                            let dashColumns : [GridItem] = [
                                GridItem(.flexible(), spacing: 8),
                                GridItem(.flexible(), spacing: 8),
                                GridItem(.flexible(), spacing: 8)
                            ]
                            
                            LazyVGrid(columns: dashColumns) {
                                
                                // Item 1 /////////////////////////////////////////////////////////////////////////////
                                VStack {
                                    
                                    HStack {
                                        Image(systemName: "terminal")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 26, height: 26)
                                            .padding(.leading, 10)
                                            .padding(.top, 10)
                                        Spacer()
                                    }
                                    
                                    
                                    HStack {
                                        
                                        GroupBoxHeadlineGroup(
                                            
                                            title1: "",
                                            title2: " formulae installed",
                                            count: "\(brewData.installedFormulae.count)",
                                            mainText: "Terminal based packages"
                                        )
                                        .animation(.none, value: brewData.installedFormulae.count)
                                    }
                                    .padding(.top, 15)
                                    Spacer()
                                    
                                    
                                }
                                .frame(width: 220, height: 160 )
                                .background(Rectangle().fill(Color("dash").opacity(1)).cornerRadius(8))
                                
                                
                                // Item 2 /////////////////////////////////////////////////////////////////////////////
                                VStack {
                                    
                                    HStack {
                                        Image(systemName: "text.and.command.macwindow")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 26, height: 26)
                                            .padding(.leading, 10)
                                            .padding(.top, 10)
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        GroupBoxHeadlineGroup(
                                            //                                            image: "text.and.command.macwindow",
                                            title1: "",
                                            title2: " \(brewData.installedCasks.count == 1 ? "cask" : "casks") installed",
                                            count: "\(brewData.installedCasks.count)",
                                            mainText: "Graphical window packages"
                                        )
                                        .animation(.none, value: brewData.installedCasks.count)
                                        .padding(.top, 15)
                                        
                                    }
                                    Spacer()
                                    
                                    
                                }
                                .frame(width: 220, height: 160 )
                                .background(Rectangle().fill(Color("dash").opacity(1)).cornerRadius(8))
                                
                                
                                // Item 3 /////////////////////////////////////////////////////////////////////////////
                                VStack {
                                    
                                    HStack {
                                        Image(systemName: "spigot")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 26, height: 26)
                                            .padding(.leading, 10)
                                            .padding(.top, 10)
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        GroupBoxHeadlineGroup(
                                            //                                            image: "spigot",
                                            title1: "",
                                            title2: " \(availableTaps.addedTaps.count == 1 ? "tap" : "taps") added",
                                            count: "\(availableTaps.addedTaps.count)",
                                            mainText: "3rd party packages"
                                        )
                                        .animation(.none, value: availableTaps.addedTaps.count)
                                        .padding(.top, 15)
                                        
                                    }
                                    Spacer()
                                    
                                    
                                }
                                .frame(width: 220, height: 160 )
                                .background(Rectangle().fill(Color("dash").opacity(1)).cornerRadius(8))
                                
                                
                                // Item 4 /////////////////////////////////////////////////////////////////////////////
                                VStack {
                                    
                                    HStack {
                                        Image(systemName: "clock.arrow.circlepath")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 26, height: 26)
                                            .padding(.leading, 10)
                                            .padding(.top, 10)
                                        Spacer()
                                        if upgradeablePackages.count > 0
                                        {
                                            
                                            Button
                                            {
                                                updateBrewPackages(updateProgressTracker, appState: appState)
                                            } label: {
                                                Image(systemName: "arrow.down.app")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 18.0, height: 18.0)
                                            }
                                            .controlSize(.large)
                                            .help("Update packages")
                                            .padding(.top, 10)
                                            .padding(.trailing, 10)
                                            
                                            
                                        }
                                    }
                                    
                                    HStack
                                    {
                                        GroupBoxHeadlineGroup(
                                            //                                            image: "clock.arrow.circlepath",
                                            title1: "",
                                            title2: " outdated \(upgradeablePackages.count == 1 ? "package" : "packages")",
                                            count: "\(upgradeablePackages.count)",
                                            mainText: "Some packages need to be updated"
                                        )
                                        .animation(.none, value: availableTaps.addedTaps.count)
                                        .padding(.top, 15)
                                        
                                        
                                    }
                                    
                                    
                                    Spacer()
                                    
                                }
                                .frame(width: 220, height: 160 )
                                .background(Rectangle().fill(Color("dash").opacity(1)).cornerRadius(8))
                                
                                
                                // Item 5 /////////////////////////////////////////////////////////////////////////////
                                VStack{
                                    
                                    HStack {
                                        Image(systemName: "square.and.arrow.down.on.square")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 26, height: 26)
                                            .padding(.leading, 10)
                                            .padding(.top, 10)
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
                                                .controlSize(.large)
                                                .help("Delete cached downloads")
                                                .padding(.top, 10)
                                                .padding(.trailing, 10)
                                            
                                        }
                                    }
                                    
                                    HStack
                                    {
                                        GroupBoxHeadlineGroup(
                                            //                                            image: "square.and.arrow.down.on.square",
                                            title1: "",
                                            title2: " cached",
                                            count: "\(appState.cachedDownloadsFolderSize.convertDirectorySizeToPresentableFormat(size: appState.cachedDownloadsFolderSize))",
                                            mainText: "Safe to remove caching"
                                        )
                                        
                                        
                                        
                                    }
                                    .padding(.top, 15)
                                    
                                    Spacer()
                                    
                                    
                                }
                                .frame(width: 220, height: 160 )
                                .background(Rectangle().fill(Color("dash").opacity(1)).cornerRadius(8))
                                
                                
                                // Item 6 /////////////////////////////////////////////////////////////////////////////
                                VStack {
                                    
                                    HStack {
                                        Image(systemName: "chart.bar")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 26, height: 26)
                                            .padding(.leading, 10)
                                            .padding(.top, 10)
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        let analyticsStatus = allowBrewAnalytics ? "ENABLED" : "DISABLED"
                                        GroupBoxHeadlineGroupAnalytics(
                                            //                                            image: "chart.bar",
                                            title: "Analytics are ",
                                            status: analyticsStatus,
                                            mainText: "\(allowBrewAnalytics ? "Homebrew is collecting various anonymized data" : "Homebrew is not collecting any data")"
                                        )
                                    }
                                    .padding(.top, 15)
                                    
                                    
                                    Spacer()
                                    
                                    
                                }
                                .frame(width: 220, height: 160 )
                                .background(Rectangle().fill(Color("dash").opacity(1)).cornerRadius(8))
                                
                                
                                
                            }
                            .padding(.vertical)
                            
                            
                            //                            GroupBox{
                            //
                            //                                VStack(alignment: .leading)
                            //                                {
                            //
                            //                                    GroupBoxHeadlineGroup(
                            //                                        image: "square.and.arrow.down.on.square",
                            //                                        title1: "Outdated Packages",
                            //                                        title2: "",
                            //                                        count: "",
                            //                                        mainText: "You may upgrade your packages above"
                            //                                    )
                            //
                            //                                    if upgradeablePackages.count > 0 {
                            //                                        List(upgradeablePackages)
                            //                                        { package in
                            //                                            Text(package.name)
                            //                                        }
                            //                                        .listStyle(.bordered(alternatesRowBackgrounds: true))
                            //                                        .frame(height: 100)
                            //                                    }
                            //
                            //                                }
                            //
                            //                            }
                            
                            
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
