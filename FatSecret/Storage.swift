//
//  Storage.swift
//  FatSecret
//
//  Created by user184905 on 12/17/20.
//

import Foundation
import FatSecretSwift
import FirebaseFirestore

class Storage {
    public static var userID : String! = nil
    private static var userFirestoreDocumentID : String! = nil
    public static let dateFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    public static let firestore = Firestore.firestore()
    public static var eatenFood: [[String: String]] = []
    public static var favoritesFood: [String] = []
    public static var name = ""
    public static var surname = ""
    public static var weight = 0.0
    public static var mail = ""
    public static var address = ""
    public static var age = 0
    public static var goals : [String] = []
    public static let fatSecretClient = FatSecretClient()
    public static func changeFavorites(id: String){
        if (favoritesFood.contains(id)){
            favoritesFood.removeAll{(str) in str == id}
        }
        else {
            favoritesFood.append(id)
        }
        updateFavoriteInFirestore()
    }
    
    public static func eatFood(id: String){
        eatenFood.append(["id": id, "date": dateFormatter.string(from: Date())])
        updateEatenInFirestore()
    }
    
    public static func deleteFood(id: String){
        let date = dateFormatter.string(from: Date())
        for i in 0..<eatenFood.count{
            if eatenFood[i]["id"] == id && eatenFood[i]["date"] == date{
                eatenFood.remove(at: i)
                break
            }
        }
        updateEatenInFirestore()
    }
    
    public static func addGoal(_ goal: String) {
        Storage.goals.append(goal)
        firestore.collection("users").document(userFirestoreDocumentID).updateData(["goals": goals])
    }
    
    public static func updateUserInfo(name: String, surname: String, age: Int, address: String, mail: String) {
        firestore.collection("users").document(userFirestoreDocumentID).updateData(["name": name])
        firestore.collection("users").document(userFirestoreDocumentID).updateData(["surname": surname])
        firestore.collection("users").document(userFirestoreDocumentID).updateData(["age": age])
        firestore.collection("users").document(userFirestoreDocumentID).updateData(["address": address])
        firestore.collection("users").document(userFirestoreDocumentID).updateData(["mail": mail])
    }
    
    public static func foodIsEatenToday(id: String) -> Bool{
        let date = dateFormatter.string(from: Date())
        for food in eatenFood{
            if food["id"] == id && food["date"] == date {
                return true
            }
        }
        return false
    }
     
    public static func fetchDataFromFirestore(completion: (() -> Void)? = nil) {
        firestore.collection("users").whereField("uid", isEqualTo: userID!).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if querySnapshot!.documents.count == 0 {
                    createUser()
                    firestore.collection("users").whereField("uid", isEqualTo: userID!).getDocuments() { (querySnapshot, err) in
                        userFirestoreDocumentID = querySnapshot!.documents[0].documentID
                        
                        favoritesFood = []
                        eatenFood = []
                        weight = 0.0
                        name = ""
                        surname = ""
                        goals = []
                        age = 0
                        address = ""
                        mail = ""
                        
                    }
                }
                else {
                    let document = querySnapshot!.documents[0]
                    userFirestoreDocumentID = document.documentID
                    favoritesFood = document.data()["favorites"] as! [String]
                    eatenFood = document.data()["eatenFood"] as! [[String: String]]
                    weight = document.data()["weight"] as! Double
                    name = document.data()["name"] as! String
                    surname = document.data()["surname"] as! String
                    goals = document.data()["goals"] as! [String]
                    age = document.data()["age"] as! Int
                    address = document.data()["address"] as! String
                    mail = document.data()["mail"] as! String
                }
                
                if completion != nil {
                    completion!()
                }
                
            }
        }
    }
    
    private static func createUser(){
        let newUser = ["uid": userID!,
                       "favorites": [String](),
                       "eatenFood": [[String: String]](),
                       "weight": 0.0,
                       "name": "",
                       "surname": "",
                       "goals": [String](),
                       "age": 0,
                       "address": "",
                       "mail": ""
        ] as [String : Any]
        firestore.collection("users").addDocument(data: newUser) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("User added")
            }
        }
    }
    
    private static func updateFavoriteInFirestore(){
        firestore.collection("users").document(userFirestoreDocumentID).updateData(["favorites": favoritesFood])
    }
    
    private static func updateEatenInFirestore(){
        firestore.collection("users").document(userFirestoreDocumentID).updateData(["eatenFood": eatenFood])
    }
}
