//
//  ViewController.swift
//  Jog Tracker
//
//  Created by Дмитрий Болоников on 7/5/19.
//  Copyright © 2019 Дмитрий Болоников. All rights reserved.
//

import UIKit

class JogTrackerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var jogTracker = JogTracker(jogs: [])
    @IBOutlet weak var LoggedOffStackView: UIStackView!
    @IBOutlet weak var jogsTableView: UITableView!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        LoggedOffStackView.isHidden = jogTracker.isLoggedIn
        jogsTableView.isHidden = !jogTracker.isLoggedIn
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jogTracker.jogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "JogCell", for: indexPath) as? JogCell else { return UITableViewCell() }
        let jog = jogTracker.jogs[indexPath.row]
        let speed = jog.distance / Double(jog.time)
        cell.configureCell(date: jog.date, speed: String(speed), distance: String(jog.distance), time: String(jog.time))
        return cell
    }

}

