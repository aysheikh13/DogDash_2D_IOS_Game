//
//  JSONClass.swift
//  DogDash
//
//  Created by Aynin Sheikh on 5/8/25.
//

import Foundation

class JSONClass {
    // Here we are creating a single global instance of the class that can be used across all swift files/views
    static let singleInstance = JSONClass()
        
    private var currentPlayer: User?
    
    private(set) var users: [User] = []
    
    let JSONFileName = "userInfo.JSON"
    
    
    private func getJSONFileURL() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(JSONFileName)
    }
    
    func addUser(_ user:User) {
        users.append(user)
        saveUser()
    }
    
    
    func updateUser(_ user:User)
    {
        if let indexUpdate = users.firstIndex(where: {$0.email == user.email})
        {
            users[indexUpdate] = user
            saveUser()
        }
    }
    
    func setCurrentPlayer(username: String, password: String) {
        if let user = users.first(where: { $0.username == username && $0.password == password }) {
            self.currentPlayer = user
        }
    }
    
    func updatePlayerCoins(newCoins: Int) {
        guard var currentPlayer = self.currentPlayer else { return }
        currentPlayer.coins += newCoins
        
        self.currentPlayer = currentPlayer
        
        if var allUsers = loadUsers() {
            if let newIndex = allUsers.firstIndex(where: { $0.username == currentPlayer.username }) {
                allUsers[newIndex].coins = self.currentPlayer?.coins ?? 0

            }
        }
        
    }
    
    func getPlayerCoins() -> Int? {
        return self.currentPlayer?.coins
    }
    
    func updateCurrentDog(newDog: String) {
        guard var currentPlayer = self.currentPlayer else { return }
        currentPlayer.currentDog = newDog
        
        self.currentPlayer = currentPlayer
        
        if var allUsers = loadUsers() {
            if let newIndex = allUsers.firstIndex(where: { $0.username == currentPlayer.username }) {
                allUsers[newIndex].currentDog = currentPlayer.currentDog
                saveUser()
            }
        }
    }
    
    func getCurrentDog() -> String? {
        return self.currentPlayer?.currentDog
    }
    
    func loadUsers() -> [User]? {
        let url = getJSONFileURL()
        guard let data = try? Data(contentsOf: url) else{
            return nil
        }
        
        do{
            let decodedUsers = try JSONDecoder().decode([User].self, from: data)
            users = decodedUsers
            return users
        } catch {
            users = []
            return users
        }

    }
    
    func saveUser() {
        
        guard var updatedUsers = loadUsers() else {
            print("Failed to load users.")
            return
        }
        
        guard let currentPlayer = self.currentPlayer else {
            print("No current player available.")
            return
        }
        if let index = updatedUsers.firstIndex(where: { $0.username == currentPlayer.username }) {
            updatedUsers[index].coins = currentPlayer.coins
            
            }
        
        if let data = try? JSONEncoder().encode(users) {
            let url = getJSONFileURL()
            
            try? data.write(to: url)
        }
    }
}
