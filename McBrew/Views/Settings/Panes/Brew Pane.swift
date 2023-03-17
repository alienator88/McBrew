//
//  Brew Pane.swift
//  McBrew
//
//  Created by alienator88 on 06.03.2023.
//

import Foundation
import SwiftUI

struct BrewPane: View
{
    
    @AppStorage("allowBrewAnalytics") var allowBrewAnalytics: Bool = true
    @State private var isPerformingBrewAnalyticsChangeCommand: Bool = false
    
    var body: some View
    {
        SettingsPaneTemplate {
            
            VStack(alignment: .center){
//                Text("Homebrew options")
//                    .font(.headline)
                
                HStack{
                    Text("Allow homebrew to collect analytics")
                    Spacer()
                    Toggle(isOn: $allowBrewAnalytics)
                    {
                    }
                    .toggleStyle(.switch)
                    .disabled(isPerformingBrewAnalyticsChangeCommand)
                }
                
                Text("􀅴 Homebrew collects various anonymized data on how you use it")
                    .font(.caption)
                    .foregroundColor(Color(nsColor: NSColor.systemGray))
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
            
//            Form
//            {
//                LabeledContent {
//                    Toggle(isOn: $allowBrewAnalytics) {
//                        Text("Collect analytics")
//                    }
//                    .disabled(isPerformingBrewAnalyticsChangeCommand)
//                } label: {
//                    Text("Analytics:")
//                }
//
//            }
//            .onChange(of: allowBrewAnalytics) { newValue in
//                if newValue == true
//                {
//                    Task
//                    {
//                        isPerformingBrewAnalyticsChangeCommand = true
//
//                        print("Will ENABLE analytics")
//                        var _ = await shell(AppConstants.brewExecutablePath.absoluteString, ["analytics", "on"])
//
//                        isPerformingBrewAnalyticsChangeCommand = false
//                    }
//                }
//                else if newValue == false
//                {
//                    Task
//                    {
//                        isPerformingBrewAnalyticsChangeCommand = true
//
//                        print("Will DISABLE analytics")
//                         var _ = await shell(AppConstants.brewExecutablePath.absoluteString, ["analytics", "off"])
//
//                        isPerformingBrewAnalyticsChangeCommand = false
//                    }
//                }
//            }
        }
    }
}
