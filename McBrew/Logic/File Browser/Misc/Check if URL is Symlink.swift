//
//  Check if URL is Symlink.swift
//  McBrew
//
//  Created by alienator88 on 25.02.2023.
//

import Foundation

func isSymlink(at url: URL) -> Bool
{
    
    var isSymlink: Bool?
    
    do
    {
        let fileAttributes = try url.resourceValues(forKeys: [.isSymbolicLinkKey])
        
        isSymlink = fileAttributes.isSymbolicLink
        print(isSymlink as Any)
    }
    catch let symlinkCheckingError as NSError
    {
        print(symlinkCheckingError.localizedDescription)
    }
    
    return isSymlink!
}
