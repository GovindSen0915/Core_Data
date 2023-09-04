//
//  DatabaseManager.swift
//  Core_Data
//
//  Created by Govind Sen on 03/09/23.
//

import UIKit

struct userModel {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}

class DatabaseManager{
    
    func addUser(_ user: userModel) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let userEntity = UserEntity(context: context)
        userEntity.firstName = user.firstName
        userEntity.lastName = user.lastName
        userEntity.email = user.email
        userEntity.password = user.password
        
        do {
            try context.save()
        } catch {
            print("User saving error: ", error)
        }
    }
}
