//
//  General Pane.swift
//  McBrew
//
//  Created by alienator88 on 15.02.2023.
//

import SwiftUI

struct GeneralPane: View
{
    @AppStorage("sortPackagesBy") var sortPackagesBy: PackageSortingOptions = .none
    @AppStorage("displayAdvancedDependencies") var displayAdvancedDependencies: Bool = false
    
    @AppStorage("caveatDisplayOptions") var caveatDisplayOptions: PackageCaveatDisplay = .full
    @AppStorage("caveatDisplayOptionsBool") var caveatDisplayOptionsBool: Bool = true
    @AppStorage("showDescriptionsInSearchResults") var showDescriptionsInSearchResults: Bool = false
    
    var body: some View
    {
        SettingsPaneTemplate
        {
            
            VStack(alignment: .center){
//                Text("Application options")
//                    .font(.headline)
                
                Picker(selection: $sortPackagesBy)
                {
                    Text("Name")
                        .tag(PackageSortingOptions.alphabetically)
                    Text("Installation Date")
                        .tag(PackageSortingOptions.byInstallDate)
                    Text("Size")
                        .tag(PackageSortingOptions.bySize)
                    
                    Divider()
                    
                    Text("Do Not Sort")
                        .tag(PackageSortingOptions.none)
                } label: {
                    Text("Sort packages by:")
                }
                
                if sortPackagesBy == .none
                {
                    Text("􀅴 Restart McBrew for this sorting option to take effect")
                        .font(.caption)
                        .foregroundColor(Color(nsColor: NSColor.systemGray))
                }
                
                
                HStack{
                    Text("Show more info about dependencies")
                    Spacer()
                    Toggle(isOn: $displayAdvancedDependencies)
                    {
                    }
                    .toggleStyle(.switch)
                }
                
                HStack{
                    Text("Show descriptions in package search")
                    Spacer()
                    Toggle(isOn: $showDescriptionsInSearchResults)
                    {
                    }
                    .toggleStyle(.switch)
                }
                
                HStack{
                    Text("Show full package caveats instead of mini:")
                    Spacer()
                    Toggle(isOn: $caveatDisplayOptionsBool)
                    {
                    }
                    .toggleStyle(.switch)
                }
                
                if !caveatDisplayOptionsBool // == .mini
                {
                    Text("􀅴 In package view, click on the \"Has caveats\" pill to see")
                        .font(.caption)
                        .foregroundColor(Color(nsColor: NSColor.systemGray))
                }
                
            }
            //            Form
            //            {
            //                Picker(selection: $sortPackagesBy)
            //                {
            //                    Text("Name")
            //                        .tag(PackageSortingOptions.alphabetically)
            //                    Text("Installation Date")
            //                        .tag(PackageSortingOptions.byInstallDate)
            //                    Text("Size")
            //                        .tag(PackageSortingOptions.bySize)
            //
            //                    Divider()
            //
            //                    Text("Do Not Sort")
            //                        .tag(PackageSortingOptions.none)
            //                } label: {
            //                    Text("Sort packages by:")
            //                }
            //
            //                if sortPackagesBy == .none
            //                {
            //                    Text("􀅴 Restart McBrew for this sorting option to take effect")
            //                        .font(.caption)
            //                        .foregroundColor(Color(nsColor: NSColor.systemGray))
            //                }
            
            
            
            
            //                LabeledContent {
            //                    VStack(alignment: .leading)
            //                    {
            //                        Toggle(isOn: $displayAdvancedDependencies) {
            //                            Text("Show more info about dependecies")
            //                        }
            //
            //                    }
            //                } label: {
            //                    Text("Dependencies:")
            //                }
            
            //                Picker(selection: $caveatDisplayOptions) {
            //                    Text("Full")
            //                        .tag(PackageCaveatDisplay.full)
            //                    Text("Minified")
            //                        .tag(PackageCaveatDisplay.mini)
            //                } label: {
            //                    Text("Package caveats:")
            //                }
            //                .pickerStyle(.radioGroup)
            //                if caveatDisplayOptions == .mini
            //                {
            //                    Text("􀅴 Click on the \"Has caveats\" pill to see the caveats")
            //                        .font(.caption)
            //                        .foregroundColor(Color(nsColor: NSColor.systemGray))
            //                }
            //
            //                LabeledContent {
            //                    Toggle(isOn: $showDescriptionsInSearchResults) {
            //                        Text("Show package descriptions")
            //                    }
            //                } label: {
            //                    Text("New package search:")
            //                }
            
            
            //            }
        }
    }
}
