//
//  ViewController.swift
//  Test
//
//  Created by Marcelo Sampaio on 15/04/19.
//  Copyright © 2019 Marcelo Sampaio. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    // MARK: - Properties
    
    // Get singleton class which manage WCSession
    var connectivityHandler = SessionHandler.shared
    
    // Counter for manage number of messages sended
    var messagesCounter = 0
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    // MARK: - UI Actions
    @IBAction func sendMessageToWatch(_ sender: Any) {
        messagesCounter += 1
        // Send message to apple watch, we don't wait to response, only trace errors
        
        connectivityHandler.session.sendMessage(["msg" : "Msg \(messagesCounter)"], replyHandler: nil) { (error) in
            print("Error sending message: \(error)")
        }
        
        
        
        
        
    }
    

}

