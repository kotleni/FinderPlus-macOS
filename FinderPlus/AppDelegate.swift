//
//  AppDelegate.swift
//  FinderPlus
//
//  Created by Victor Varenik on 10.08.2022.
//

import Cocoa
import FinderSync

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if !FIFinderSyncController.isExtensionEnabled {
            FIFinderSyncController.showExtensionManagementInterface()
        }
        
        exit(0)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
