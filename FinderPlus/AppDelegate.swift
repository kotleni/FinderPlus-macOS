//
//  AppDelegate.swift
//  FinderPlus
//
//  Created by Viktor Varenik on 10.08.2022.
//

import Cocoa
import FinderSync

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        FIFinderSyncController.showExtensionManagementInterface()
        //NSApplication.shared.terminate(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
