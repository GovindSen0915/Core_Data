//
//  RegisterViewController.swift
//  Core_Data
//
//  Created by Govind Sen on 03/09/23.
//

import UIKit
import PhotosUI

class RegisterViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    
    private var imageSelectedByUser: Bool = false
    private let manager = DatabaseManager()
    
    var user: UserEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
}

extension RegisterViewController {
    
    func configuration() {
        uiConfiguration()
        addGesture()
        userDetailConfiguration()
    }
    
    func uiConfiguration() {
        navigationItem.title = "Add User"
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
    }
    
    func addGesture() {
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.openGallery))
        profileImageView.addGestureRecognizer(imageTap)
    }
    
    func userDetailConfiguration() {
        if let user {
            registerButton.setTitle("Update", for: .normal)
            navigationItem.title = "Update User"
            firstNameField.text = user.firstName
            lastNameField.text = user.lastName
            emailField.text = user.email
            passwordField.text = user.password
            
            let imageURL = URL.documentsDirectory.appending(components: user.imageName ?? "").appendingPathExtension("png")
            profileImageView.image = UIImage(contentsOfFile: imageURL.path)
            
            imageSelectedByUser = true
        } else {
            navigationItem.title = "Add User"
            registerButton.setTitle("Register", for: .normal)
        }
    }
    
    @IBAction func resgisterButtonTapped(_ sender: UIButton) {
        guard let firstName = firstNameField.text, !firstName.isEmpty else {
            openAlert(message: "Please enter your first name")
            return
        }
        
        guard let lastName = lastNameField.text, !lastName.isEmpty else {
            openAlert(message: "Please enter your last name")
            return
        }
        
        guard let email = emailField.text, !email.isEmpty else {
            openAlert(message: "Please enter your email address")
            return
        }
        
        guard let password = passwordField.text, !password.isEmpty else {
            openAlert(message: "Please enter your password")
            return
        }
        
        if !imageSelectedByUser {
            openAlert(message: "Please choose your profile image.")
        }
        
        let imageName = UUID().uuidString
        
        var newUser = UserModel(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            imageName: imageName
        )
        
        if let user {
            // update
            newUser.imageName = user.imageName ?? ""
            manager.updateUser(user: newUser, userEntity: user)
            saveImageToDocumentDirectory(imageName: user.imageName ?? "")
            
            
        } else {
            // add
            saveImageToDocumentDirectory(imageName: imageName)
            manager.addUser(newUser)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func saveImageToDocumentDirectory(imageName: String) {
        let fileURL = URL.documentsDirectory.appending(path: imageName).appendingPathExtension("png")
        if let data = profileImageView.image?.pngData() {
            do {
                try data.write(to: fileURL)
            } catch {
                print("Saving image to document directory error: ", error)
            }
        }
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: nil, message: "User added", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okay)
        present(alertController, animated: true)
    }
    
    @objc func openGallery() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        
        let pickerVC = PHPickerViewController(configuration: config)
        pickerVC.delegate = self
        present(pickerVC, animated: true)
        
    }
}

extension RegisterViewController {
    func openAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okay)
        present(alertController, animated: true)
    }
}

extension RegisterViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                guard let image = image as? UIImage else { return }
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                    self.imageSelectedByUser = true
                }
            }
        }
    }
}
