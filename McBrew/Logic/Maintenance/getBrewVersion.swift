//
//  getBrewVersion.swift
//  McBrew
//
//  Created by Alin Lupascu on 3/15/23.
//

import Foundation

@MainActor
func getBrewVersion(appState: AppState) async
{
    print("Started healthcheck task at \(Date())")
    
//    appState.isRunningHealthCheck = true
    
    Task {
        
            let verResult = await shell(AppConstants.brewExecutablePath.absoluteString, ["version"]).standardOutput
            print("Health check output: \(verResult)")
//            appState.isHealthCheckGood = true
            
        
    }

//    appState.isRunningHealthCheck = false
    
    
}
