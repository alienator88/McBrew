//
//  runHealthCheck.swift
//  McBrew
//
//  Created by Alin Lupascu on 3/15/23.
//

import Foundation

@MainActor
func runHealthCheck(appState: AppState) async
{
    print("Started healthcheck task at \(Date())")
    
    appState.isRunningHealthCheck = true
    
    Task {
        do
        {
            let healthCheckOutput = try await performBrewHealthCheck()
            print("Health check output: \(healthCheckOutput)")
            appState.isHealthCheckGood = true
            
        }
        catch let healthCheckError as NSError
        {
            print(healthCheckError)
            appState.isHealthCheckGood = false
        }
    }

    appState.isRunningHealthCheck = false
    
    
}
