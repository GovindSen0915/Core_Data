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
        addUpdateUser(user: user, userEntity: userEntity)
    }
    
    func updateUser(user: UserModel, userEntity:UserEntity) {
        addUpdateUser(user: user, userEntity: userEntity)
        
    }
    
    private func addUpdateUser(user: UserModel, userEntity: UserEntity) {
        userEntity.firstName = user.firstName
        userEntity.lastName = user.lastName
        userEntity.email = user.email
        userEntity.password = user.password
        userEntity.imageName = user.imageName
        saveContext()
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
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("User saving error:", error)
        }
    }
    
    func deleteUser(userEntity: UserEntity) {
        context.delete(userEntity)
        saveContext()
    }
    
}
