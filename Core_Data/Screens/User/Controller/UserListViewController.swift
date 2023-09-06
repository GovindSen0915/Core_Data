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
    private let manager = DatabaseManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        userTableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        users = manager.fetchUsers()
        userTableView.reloadData()
        
    }
    
    @IBAction func addUserButtonTapped(_ sender: UIBarButtonItem) {
        addUpdateUserNavigation()
    }
    
    func addUpdateUserNavigation(user: UserEntity? = nil) {
        guard let registervC = self.storyboard?.instantiateViewController(identifier: "RegisterViewController") as? RegisterViewController else { return }
        registervC.user = user
        navigationController?.pushViewController(registervC, animated: true)
    }
    
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell else {
            return UITableViewCell()
        }
        let user = users[indexPath.row]
        cell.user = user
        return cell
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let update = UIContextualAction(style: .normal, title: "Update") { _, _, _ in
            self.addUpdateUserNavigation(user: self.users[indexPath.row])
        }
        update.backgroundColor = .systemIndigo
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.manager.deleteUser(userEntity: self.users[indexPath.row]) // core data
            self.users.remove(at: indexPath.row) // Array
            self.userTableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [update, delete])
    }
}
