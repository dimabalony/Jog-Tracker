//
//  ViewController.swift
//  Jog Tracker
//
//  Created by Дмитрий Болоников on 7/5/19.
//  Copyright © 2019 Дмитрий Болоников. All rights reserved.
//

import UIKit

class JogTrackerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var jogTracker = JogTracker()
    @IBOutlet weak var LoggedOffStackView: UIStackView!
    @IBOutlet weak var jogsTableView: UITableView!
    @IBOutlet weak var jogsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jogsTableView.dataSource = self
        jogsTableView.delegate = self
        
//        navigationController?.setNavigationBarHidden(false, animated: false)
//        navigationController?.isNavigationBarHidden = false
//        var backButtonBackgroundImage = #imageLiteral(resourceName: "menu")
//
//        backButtonBackgroundImage =
//            backButtonBackgroundImage.resizableImage(withCapInsets:
//                UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
//        
//        let barAppearance =
//            UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self])
//        barAppearance.backIndicatorImage = backButtonBackgroundImage
//        barAppearance.backIndicatorTransitionMaskImage = backButtonBackgroundImage
//
//        // Provide an empty backBarButton to hide the 'Back' text present by default in the back button.
//        let backBarButton = UIBarButtonItem(title: "qwe", style: .plain, target: nil, action: nil)
//        navigationItem.leftBarButtonItem?.image = backButtonBackgroundImage
    }
    
    @IBAction func touchLetMeIn(_ sender: Any) {
        guard let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            assertionFailure("Incorrent Storyboard ID")
            return
        }
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    @IBAction func touchAddJog(_ sender: Any) {
        let addJogViewController = JogEditorViewController { (jog) in
            self.jogTracker.addJog(jog)
        }
        present(addJogViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        JogService.instance.refreshJogs { (success) in
            guard success else { return }
            self.jogsTableView.reloadData()
        }
        LoggedOffStackView.isHidden = jogTracker.isLoggedIn
        jogsView.isHidden = !jogTracker.isLoggedIn
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jogTracker.jogs.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "JogCell", for: indexPath) as? JogCell else { return UITableViewCell() }
        let jog = jogTracker.jogs[indexPath.row]
        let speed = jog.timeSince1970 != 0 ? jog.distance / Double(jog.timeSince1970) : 0
        cell.configureCell(date: jog.date, speed: String(format: "%.2f", speed), distance: String(jog.distance), time: String(jog.timeSince1970))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

