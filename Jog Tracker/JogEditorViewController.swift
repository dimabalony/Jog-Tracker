//
//  AddJogViewController.swift
//  Jog Tracker
//
//  Created by Дмитрий Болоников on 7/6/19.
//  Copyright © 2019 Дмитрий Болоников. All rights reserved.
//

import UIKit

class JogEditorViewController: UIViewController {
    
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    let completion: (_ jog: Jog) ->()
    
    init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil, completion: @escaping (_ jog: Jog) ->()) {
        self.completion = completion
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .custom
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.completion = { jog in }
        super.init(coder: aDecoder)
        modalPresentationStyle = .custom

    }
    
    @IBAction func touchClose(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func touchSave(_ sender: Any) {
        guard let distanceString = distanceTextField.text, let distance = Double(distanceString), let timeString = timeTextField.text, let time = Int(timeString), let date = dateTextField.text, let jog = Jog(distance: distance, time: time, date: date) else { return }
        completion(jog)
        dismiss(animated: true)
    }
}
