//
//  ViewController.swift
//  Messenger
//
//  Created by saw Tarmalar on 14/06/2020.
//  Copyright © 2020 saw Tarmalar. All rights reserved.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
       validateAuth()
        
       
    }
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
                   let vc = LoginViewController()
                   let nav = UINavigationController(rootViewController: vc)
                   nav.modalPresentationStyle = .fullScreen
                   present(nav, animated: false)
               }
    }
    


}

