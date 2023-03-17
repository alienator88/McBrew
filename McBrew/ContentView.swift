//
//  ContentView.swift
//  McBrew
//
//  Created by alienator88 on 03.07.2022.
//

import SwiftUI

struct ContentView: View
{
    @AppStorage("sortPackagesBy") var sortPackagesBy: PackageSortingOptions = .none
    @AppStorage("allowBrewAnalytics") var allowBrewAnalytics: Bool = true
    
    @EnvironmentObject var appState: AppState

    @EnvironmentObject var brewData: BrewDataStorage
    @EnvironmentObject var availableTaps: AvailableTaps

    @EnvironmentObject var selectedPackageInfo: SelectedPackageInfo
    
    @EnvironmentObject var updateProgressTracker: UpdateProgressTracker

    @State private var multiSelection = Set<UUID>()

    @State private var isShowingAlert: Bool = false

    var body: some View
    {
        VStack
        {
            let multipleCask = brewData.installedCasks.count == 1 ? "cask" : "casks"
            NavigationView
            {
                SidebarView()

                StartDash() // StartPage for old view
                    .frame(minWidth: 600, minHeight: 500)
            }
            .navigationTitle("McBrew")
            .navigationSubtitle("\(brewData.installedFormulae.count) formulae, \(brewData.installedCasks.count) \(multipleCask), \(availableTaps.addedTaps.count) taps")
///            .navigationSubtitle("\(brewData.installedFormulae.count + brewData.installedCasks.count) packages installed")
            .toolbar
            {

                ToolbarItemGroup(placement: .primaryAction)
                {
                    Button
                    {
                        appState.isShowingInstallationSheet.toggle()
                    } label: {
                        Label
                        {
                            Text("Add package")
                        } icon: {
                            Image(systemName: "plus")
                        }
                    }
                    .help("Add a new package")
                    
                    Spacer()
                    
                    Button
                    {
                        appState.isShowingAddTapSheet.toggle()
                    } label: {
                        Label
                        {
                            Text("Add Tap")
                        } icon: {
                            Image(systemName: "spigot")
                        }
                    }
                    .help("Add a new tap")
                    
                    Spacer()
                    
                    Button
                    {
                        updateBrewApp(updateProgressTracker, appState: appState)
                    } label: {
                        Label
                        {
                            Text("Upgrade Homebrew")
                        } icon: {
                            Image(systemName: "cup.and.saucer")
                        }
                    }
                    .help("Upgrade homebrew app")
                    .overlay(arrowDown, alignment: .topTrailing)

                    Spacer()
                    
                    Button
                    {
                        upgradeBrewPackages(updateProgressTracker, appState: appState)
                    } label: {
                        Label
                        {
                            Text("Update Homebrew Packages")
                        } icon: {
                            Image(systemName: "shippingbox")
                        }
                    }
                    .help("Update installed homebrew packages")
                    .overlay(arrowDown, alignment: .topTrailing)

                    Spacer()

                    Button
                    {
                        print("Would perform maintenance")
                        appState.isShowingMaintenanceSheet.toggle()
                    } label: {
                        Label
                        {
                            Text("Maintenance")
                        } icon: {
                            Image(systemName: "arrow.3.trianglepath")
                        }
                    }
                    .help("Maintenance")
                    
                }
            }
        }
        .frame(minHeight: 650)
        .onAppear
        {
            print("Brew executable path: \(AppConstants.brewExecutablePath.absoluteString)")
            Task
            {
                async let analyticsQueryCommand = await shell(AppConstants.brewExecutablePath.absoluteString, ["analytics"])

                brewData.installedFormulae = await loadUpFormulae(appState: appState, sortBy: sortPackagesBy)
                brewData.installedCasks = await loadUpCasks(appState: appState, sortBy: sortPackagesBy)
                availableTaps.addedTaps = await loadUpTappedTaps()
                _ = await runHealthCheck(appState: appState)
                _ = await getBrewVersion(appState: appState)
                
                if await analyticsQueryCommand.standardOutput.contains("Analytics are enabled")
                {
                    allowBrewAnalytics = true
                    print("Analytics are ENABLED")
                }
                else
                {
                    allowBrewAnalytics = false
                    print("Analytics are DISABLED")
                }
            }
        }
        .onChange(of: sortPackagesBy, perform: { newSortOption in
            switch newSortOption {
            case .none:
                print("Chose NONE")
                
            case .alphabetically:
                print("Chose ALPHABETICALLY")
                brewData.installedFormulae = sortPackagesAlphabetically(brewData.installedFormulae)
                brewData.installedCasks = sortPackagesAlphabetically(brewData.installedCasks)
                
            case .byInstallDate:
                print("Chose BY INSTALL DATE")
                brewData.installedFormulae = sortPackagesByInstallDate(brewData.installedFormulae)
                brewData.installedCasks = sortPackagesByInstallDate(brewData.installedCasks)
                
            case .bySize:
                print("Chose BY SIZE")
                brewData.installedFormulae = sortPackagesBySize(brewData.installedFormulae)
                brewData.installedCasks = sortPackagesBySize(brewData.installedCasks)
            }
        })
        .sheet(isPresented: $appState.isShowingInstallationSheet)
        {
            AddFormulaView(isShowingSheet: $appState.isShowingInstallationSheet)
        }
        .sheet(isPresented: $appState.isShowingAddTapSheet)
        {
            AddTapView(isShowingSheet: $appState.isShowingAddTapSheet)
        }
        .sheet(isPresented: $appState.isShowingUpdateSheet)
        {
            VStack
            {
                ProgressView(value: updateProgressTracker.updateProgress)
                    .frame(width: 200)
                Text(updateProgressTracker.updateStage.rawValue)
            }
            .padding()
        }
        .alert(isPresented: $appState.isShowingUninstallationNotPossibleDueToDependencyAlert, content: {
            Alert(title: Text("Could Not Uninstall"), message: Text("This package is a dependency of \(appState.offendingDependencyProhibitingUninstallation)"), dismissButton: .default(Text("Close"), action: {
                appState.isShowingUninstallationNotPossibleDueToDependencyAlert = false
            }))
        })
    }
}


private var arrowDown: some View {
        Image(systemName: "arrow.down")
        .resizable()
        .scaledToFit()
        .frame(width: 10.0, height: 10.0)
        .padding([.trailing], 2)
    }
