//
//  InterfaceController.swift
//  Test WatchKit Extension
//
//  Created by Marcelo Sampaio on 15/04/19.
//  Copyright © 2019 Marcelo Sampaio. All rights reserved.
//


import Foundation
import WatchKit
import WatchConnectivity


class InterfaceController: WKInterfaceController {
    
    // MARK: - Outlets
    @IBOutlet weak var table: WKInterfaceTable!
    
    // MARK: - Properties
    private var session = WCSession.default
    private var items = [String]()

    

    // MARK: - Watch Life Cycle
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        items.append("Linha 0")

//        self.updateTable()
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        // Initialization of session and set as delegate this InterfaceController if it's supported
        if isSuported() {
            session.delegate = self
            session.activate()
        }
        
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    // MARK: - Watch Data Source Helper
    func updateTable() {
        table.setNumberOfRows(items.count, withRowType: "Row")
        for (i, item) in items.enumerated() {
            if let row = table.rowController(at: i) as? Row {
                row.lbl.setText(item)
            }
        }
    }
    private func isSuported() -> Bool {
        return WCSession.isSupported()
    }
    
    private func isReachable() -> Bool {
        return session.isReachable
    }
    
    // MARK: - UI Actions
    @IBAction func sendMessage() {
        print("🎗 send message action")
        /**
         *  The iOS device is within range, so communication can occur and the WatchKit extension is running in the
         *  foreground, or is running with a high priority in the background (for example, during a workout session
         *  or when a complication is loading its initial timeline data).
         */
        if isReachable() {
            session.sendMessage(["request" : "version"], replyHandler: { (response) in
                print("🏵 RESPONSE: \(response)")
                self.items.append("Reply: \(response)")
                self.updateTable()
                
            }, errorHandler: { (error) in
                print("Error sending message: %@", error)
            })
        } else {
            print("iPhone is not reachable!!")
        }
    }
    
    
    
    
    // Receive messages from iPhone
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        // 1: We launch a sound and a vibration
        WKInterfaceDevice.current().play(.notification)
        // 2: Get message and append to list
        let msg = message["msg"]!
        self.items.append("\(msg)")
        self.updateTable()
    }
    
    
}


// MARK: - Extensions

extension InterfaceController: WCSessionDelegate {
    
    // 4: Required stub for delegating session
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("🎨 activationDidCompleteWith activationState:\(activationState) error:\(String(describing: error))")
        
//        ///////
//        if isReachable() {
//            session.sendMessage(["request" : "version"], replyHandler: { (response) in
//                print("🏵 RESPONSE: \(response)")
//                self.items.append("Reply: \(response)")
//                self.updateTable()
//
//            }, errorHandler: { (error) in
//                print("Error sending message: %@", error)
//            })
//        } else {
//            print("iPhone is not reachable!!")
//        }
//        ///////
        
        
        
        
        
        
        
    }
    
}
