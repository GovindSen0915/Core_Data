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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        users = manager.fetchUsers()
        userTableView.reloadData()
        
    }
    
    
    @IBAction func addUserButtonTapped(_ sender: UIBarButtonItem) {
        guard let registervC = self.storyboard?.instantiateViewController(identifier: "RegisterViewController") as? RegisterViewController else { return }
        navigationController?.pushViewController(registervC, animated: true)
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
        
        let imageURL = URL.documentsDirectory.appending(components: user.imageName ?? "").appendingPathExtension("png")
        content.image = UIImage(contentsOfFile: imageURL.path)
        
        var imagePro = content.imageProperties
        imagePro.maximumSize = CGSize(width: 80, height: 80)
        content.imageProperties = imagePro
        cell.contentConfiguration = content
        
        return cell
    }
}
