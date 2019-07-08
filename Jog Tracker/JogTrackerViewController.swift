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
    var refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateJogsTable), name: .updateJogsTable, object: nil)
        refresh.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        jogsTableView.addSubview(refresh)
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
    
    @objc func handleRefresh() {
        jogTracker.updateJogs()
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
            self.jogTracker.addJog(jog: jog)
        }
        present(addJogViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        jogTracker.updateJogs()
        LoggedOffStackView.isHidden = jogTracker.isLoggedIn
        jogsView.isHidden = !jogTracker.isLoggedIn
    }
    
    @objc func updateJogsTable() {
        jogsTableView.reloadData()
        refresh.endRefreshing()
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
        let speed = jog.time != 0 ? jog.distance / Double(jog.time / 60) : 0
        cell.configureCell(date: jog.date, speed: String(format: "%.2f", speed), distance: String(jog.distance), time: String(jog.time))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .default, title: "Delete") { (rowAction, indexPath) in
            self.jogTracker.deleteJog(jog: self.jogTracker.jogs[indexPath.row])
        }
        deleteButton.backgroundColor = .red
        let editButton = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            let addJogViewController = JogEditorViewController { (jog) in
                self.jogTracker.editJog(jog: jog)
            }
            addJogViewController.jog = self.jogTracker.jogs[indexPath.row]
            self.present(addJogViewController, animated: true)
        }
        editButton.backgroundColor = .orange
        return [deleteButton, editButton]
    }
}

