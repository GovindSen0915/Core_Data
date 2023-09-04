//
//  UserListViewController.swift
//  Core_Data
//
//  Created by Govind Sen on 04/09/23.
//

import UIKit

class UserListViewController: UIViewController {

    @IBOutlet weak var userTableView: UITableView!
    
    private var users: [UserEntity] = []
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func addUserButtonTapped(_ sender: UIBarButtonItem) {
    }

}
