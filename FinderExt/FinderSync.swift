//
//  FinderSync.swift
//  FinderExt
//
//  Created by Victor Varenik on 10.08.2022.
//

import Cocoa
import FinderSync

class FinderSync: FIFinderSync {
    
    override init() {
        super.init()
        
        // set up the directory we are syncing
        FIFinderSyncController.default().directoryURLs = [URL(fileURLWithPath: "/")]
    }
    
    override func menu(for menuKind: FIMenuKind) -> NSMenu {
        // produce a menu for the extension
        let menu = NSMenu(title: "")
        menu.addItem(withTitle: "Создать файл", action: #selector(createEmptyFileClicked(_:)), keyEquivalent: "")
        menu.addItem(withTitle: "Открыть терминал", action: #selector(openTerminalClicked(_:)), keyEquivalent: "")

        return menu
    }

    /// Open a macOS terminal window in current folder
    @IBAction func openTerminalClicked(_ sender: AnyObject?) {
        guard let target = FIFinderSyncController.default().targetedURL() else {
            return
        }
        
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/open")
        task.arguments = ["-a", "terminal", "\(target.path)"]
        
        do {
            try task.run()
        } catch let error as NSError {
            print("Failed to open Terminal.app: \(error.description)")
        }
    }

    /// Creates an empty file with name "untitled" under the user-chosen Finder folder.
    /// If file already exists, append it with a counter.
    @IBAction func createEmptyFileClicked(_ sender: AnyObject?) {
        guard let target = FIFinderSyncController.default().targetedURL() else {
            return
        }

        var originalPath = target
        let originalFilename = "newfile"
        var filename = "newfile.txt"
        let fileType = ".txt"
        var counter = 1
        
        while FileManager.default.fileExists(atPath: originalPath.appendingPathComponent(filename).path) {
            filename = "\(originalFilename)\(counter)\(fileType)"
            counter+=1
            originalPath = target
        }
        
        do {
            try "".write(to: target.appendingPathComponent(filename), atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed to create file: \(error.description)")
        }
    }
}
