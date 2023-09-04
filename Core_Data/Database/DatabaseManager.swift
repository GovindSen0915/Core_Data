//
//  DatabaseManager.swift
//  Core_Data
//
//  Created by Govind Sen on 03/09/23.
//

import UIKit
import CoreData

class DatabaseManager {
    
    private var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func addUser(_ user: UserModel) {
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
    
    func fetchUsers() -> [UserEntity] {
        var users: [UserEntity] = []
        
        
        do {
            users = try context.fetch(UserEntity.fetchRequest())
        } catch {
            print("Fetch user error", error)
        }
        return users
    }
    
}
