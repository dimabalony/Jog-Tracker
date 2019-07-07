//
//  LoginViewController.swift
//  Jog Tracker
//
//  Created by Дмитрий Болоников on 7/5/19.
//  Copyright © 2019 Дмитрий Болоников. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var uuidTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        guard let uuid = uuidTextField.text else { return }
        AuthService.instance.loginUser(uuid: uuid) { (success) in
            if success {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
