//
//  WebshellViewDid.swift
//  WebShell
//
//  Created by Wesley de Groot on 31-01-16.
//  Copyright © 2016 RandyLu. All rights reserved.
//

import Cocoa
import Foundation
import AppKit
import Darwin

// See: #43
extension ViewController {
	override func viewDidAppear() {
		if (firstAppear) {
			initWindow()
		}
	}

	// @wdg Possible fix for Mavericks
	// Issue: #18
	override func awakeFromNib() {
		// if (![self respondsToSelector:@selector(viewWillAppear)]) {

		if (!NSViewController().respondsToSelector(#selector(NSViewController.viewWillAppear))) {
            checkSettings()
            
            let myPopup: NSAlert = NSAlert()
            myPopup.messageText = "Hello!"
            myPopup.informativeText = "You are running mavericks?"
            myPopup.alertStyle = NSAlertStyle.InformationalAlertStyle
            myPopup.addButtonWithTitle("Yes")
            myPopup.addButtonWithTitle("No")
            
            let res = myPopup.runModal()
            
            
			print("MAVERICKS \(res)")

			// OS X 10.9
			if (firstAppear) {
				initWindow()
			}

			mainWebview.UIDelegate = self
			mainWebview.resourceLoadDelegate = self
			mainWebview.downloadDelegate = self

			addObservers()
			initSettings()
			goHome()
            WSMediaLoop(self)
            WSinitSwipeGestures()
		}
	}

	override func viewDidLoad() {
        checkSettings()
        //self.view = goodView()
		super.viewDidLoad()

		mainWebview.UIDelegate = self
		mainWebview.resourceLoadDelegate = self
		mainWebview.downloadDelegate = self
        WebShellSettings["WSMW"] = mainWebview;
        
		checkSettings()
		addObservers()
		initSettings()
		goHome()
        WSMediaLoop(self)
        WSinitSwipeGestures()
	}
}