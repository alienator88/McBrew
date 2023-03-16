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
    print("Started Homebrew version task at \(Date())")
    
    appState.isGettingHomebrewVersion = true
    
    Task {
        
        let verResult = await shell(AppConstants.brewExecutablePath.absoluteString, ["-v"]).standardOutput
//        print("Homebrew version result: \(verResult)")
        appState.homebrewVersion = verResult[9..<14]
    }
    
    appState.isGettingHomebrewVersion = false

}

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }

    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
         return String(self[start...])
    }
}
