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
    @State private var isPerformingBrewAnalyticsChangeCommand: Bool = false
    
    @State private var isDisclosureGroupExpanded: Bool = false
    @State private var showingAlert = false
    
    var body: some View
    {
        VStack
        {
            if isLoadingUpgradeablePackages && appState.isRunningHealthCheck && appState.isGettingHomebrewVersion
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
                                    Text("Healthy (v\(appState.homebrewVersion))")
                                }
                                .help("Your homebrew installation is in a healthy state")
                            } else {
                                HStack {
                                    Image(systemName: "stethoscope")
                                        .foregroundColor(.red)
                                    Text("Unhealthy (v\(appState.homebrewVersion))")
                                }
                                .help("Homebrew installation is not healthy. Run the healthcheck from Maintenance.")
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
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(Color("dash-border").opacity(1), style: StrokeStyle(lineWidth: 1, dashPhase: 0))
                                        .background(RoundedRectangle(cornerRadius: 8).fill(Color("dash")))
                                        .frame(width: 220, height: 160 )
                                        

                                    VStack {

                                        HStack {
                                            Image(systemName: "terminal")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 26, height: 26)
                                                .padding(.leading, 10)
                                                .padding(.top, 10)
                                                .opacity(0.5)
                                            Spacer()
                                        }
                                        
                                        
                                        HStack {
                                            
                                            GroupBoxHeadlineGroup(
                                                
                                                title: "\(brewData.installedFormulae.count) formulae installed",
                                                mainText: "Terminal based packages"
                                            )
                                            .animation(.none, value: brewData.installedFormulae.count)
                                        }
                                        .padding(.top, 15)
                                        Spacer()
                                        
                                        
                                    }
                                   
                                    
                                    
                                }
                                

                                
                                // Item 2 /////////////////////////////////////////////////////////////////////////////
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(Color("dash-border").opacity(1), style: StrokeStyle(lineWidth: 1, dashPhase: 0))
                                        .background(RoundedRectangle(cornerRadius: 8).fill(Color("dash")))
                                        .frame(width: 220, height: 160 )
                                    
                                    VStack {
                                        
                                        HStack {
                                            Image(systemName: "text.and.command.macwindow")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 26, height: 26)
                                                .padding(.leading, 10)
                                                .padding(.top, 10)
                                                .opacity(0.5)

                                            Spacer()
                                        }
                                        
                                        HStack {
                                            GroupBoxHeadlineGroup(
                                                
                                                title: "\(brewData.installedCasks.count) \(brewData.installedCasks.count == 1 ? "cask" : "casks") installed",
                                                mainText: "Graphical window packages"
                                            )
                                            .animation(.none, value: brewData.installedCasks.count)
                                            .padding(.top, 15)
                                            
                                        }
                                        Spacer()
                                        
                                        
                                    }

                                }
                                

                                
                                
                                // Item 3 /////////////////////////////////////////////////////////////////////////////
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(Color("dash-border").opacity(1), style: StrokeStyle(lineWidth: 1, dashPhase: 0))
                                        .background(RoundedRectangle(cornerRadius: 8).fill(Color("dash")))
                                        .frame(width: 220, height: 160 )
                                    VStack {
                                        
                                        HStack {
                                            Image(systemName: "spigot")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 26, height: 26)
                                                .padding(.leading, 10)
                                                .padding(.top, 10)
                                                .opacity(0.5)

                                            Spacer()
                                        }
                                        
                                        HStack {
                                            GroupBoxHeadlineGroup(
                                                //                                            image: "spigot",
                                                title: "\(availableTaps.addedTaps.count) \(availableTaps.addedTaps.count == 1 ? "tap" : "taps") added",
                                                mainText: "3rd party packages"
                                            )
                                            .animation(.none, value: availableTaps.addedTaps.count)
                                            .padding(.top, 15)
                                            
                                        }
                                        Spacer()
                                        
                                        
                                    }
                                    
                                }
                                
                                
                                
                                
                                // Item 4 /////////////////////////////////////////////////////////////////////////////
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(Color("dash-border").opacity(1), style: StrokeStyle(lineWidth: 1, dashPhase: 0))
                                        .background(RoundedRectangle(cornerRadius: 8).fill(Color("dash")))
                                        .frame(width: 220, height: 160 )
                                  
                                    VStack {
                                        
                                        HStack {
                                            Image(systemName: "clock.arrow.circlepath")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 26, height: 26)
                                                .padding(.leading, 10)
                                                .padding(.top, 10)
                                                .opacity(0.5)

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
                                                .controlSize(.large)
                                                .help("Update packages")
                                                .padding(.top, 10)
                                                .padding(.trailing, 10)
                                                
                                                
                                            }
                                        }
                                        
                                        HStack
                                        {
                                            GroupBoxHeadlineGroup(

                                                title: "\(upgradeablePackages.count) outdated \(upgradeablePackages.count == 1 ? "package" : "packages")",
                                                mainText: "Some packages need to be updated"
                                            )
                                            .animation(.none, value: availableTaps.addedTaps.count)
                                            .padding(.top, 15)
                                            
                                            
                                        }
                                        
                                        
                                        Spacer()
                                        
                                    }

                                    
                                }
                                .padding(.top, 8)
                                
                                
                                
                                
                                // Item 5 /////////////////////////////////////////////////////////////////////////////
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(Color("dash-border").opacity(1), style: StrokeStyle(lineWidth: 1, dashPhase: 0))
                                        .background(RoundedRectangle(cornerRadius: 8).fill(Color("dash")))
                                        .frame(width: 220, height: 160 )
                                    
                                    VStack{
                                        
                                        HStack {
                                            Image(systemName: "square.and.arrow.down.on.square")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 26, height: 26)
                                                .padding(.leading, 10)
                                                .padding(.top, 10)
                                                .opacity(0.5)

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
                                                title: "\(appState.cachedDownloadsFolderSize.convertDirectorySizeToPresentableFormat(size: appState.cachedDownloadsFolderSize)) cached",
                                                mainText: "Safe to remove caching"
                                            )
                                            
                                            
                                            
                                        }
                                        .padding(.top, 15)
                                        
                                        Spacer()
                                        
                                        
                                    }

                                }
                                .padding(.top, 8)
                                
                               
                                
                                
                                // Item 6 /////////////////////////////////////////////////////////////////////////////
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(Color("dash-border").opacity(1), style: StrokeStyle(lineWidth: 1, dashPhase: 0))
                                        .background(RoundedRectangle(cornerRadius: 8).fill(Color("dash")))
                                        .frame(width: 220, height: 160 )
                                   
                                    VStack {
                                        
                                        HStack {
                                            Image(systemName: "chart.bar")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 26, height: 26)
                                                .padding(.leading, 10)
                                                .padding(.top, 10)
                                                .opacity(0.5)

                                            Spacer()
                                            
                                            Form
                                            {
                                                LabeledContent {
                                                    Toggle(isOn: $allowBrewAnalytics) {
    //                                                    Text("")
                                                    }
                                                    .disabled(isPerformingBrewAnalyticsChangeCommand)
                                                    .toggleStyle(.switch)
                                                    .controlSize(.small)
                                                } label: {
    //                                                Text("")
                                                }

                                            }
                                            .onChange(of: allowBrewAnalytics) { newValue in
                                                if newValue == true
                                                {
                                                    Task
                                                    {
                                                        isPerformingBrewAnalyticsChangeCommand = true
                                                        
                                                        print("Will ENABLE analytics")
                                                        var _ = await shell(AppConstants.brewExecutablePath.absoluteString, ["analytics", "on"])
                                                        
                                                        isPerformingBrewAnalyticsChangeCommand = false
                                                    }
                                                }
                                                else if newValue == false
                                                {
                                                    Task
                                                    {
                                                        isPerformingBrewAnalyticsChangeCommand = true
                                                        
                                                        print("Will DISABLE analytics")
                                                         var _ = await shell(AppConstants.brewExecutablePath.absoluteString, ["analytics", "off"])
                                                        
                                                        isPerformingBrewAnalyticsChangeCommand = false
                                                    }
                                                }
                                            }
                                            .padding(.trailing, 10)
                                            .padding(.top, 10)
                                        }
                                        
                                        HStack {
                                            let analyticsStatus = allowBrewAnalytics ? "ENABLED" : "DISABLED"
                                            GroupBoxHeadlineGroupAnalytics(
                                                
                                                title: "Analytics are \(analyticsStatus)",
                                                mainText: "\(allowBrewAnalytics ? "Homebrew is collecting data" : "Homebrew is not collecting any data")"
                                            )
                                        }
                                        .padding(.top, 15)
                                        
                                        
                                        Spacer()
                                        
                                        
                                    }

                                }
                                .padding(.top, 8)
                                
                                
                                
                                
                            }
                            .padding(.vertical)
                            
                            
                            // Make packages list show up somewhere else
                            
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
