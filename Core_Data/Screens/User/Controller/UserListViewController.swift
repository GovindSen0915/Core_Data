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

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        
        let user = users[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = (user.firstName ?? "") + " " + (user.lastName ?? "") // title
        content.secondaryText = "Email: \(user.email ?? "")" // subTitle
        cell.contentConfiguration = content
        
        return cell
    }
}
