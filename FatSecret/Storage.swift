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
    private static let dateFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    public static let firestore = Firestore.firestore()
    public static var eatenFood: [[String: String]] = []
    public static var favoritesFood: [String] = []
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
     
    public static func updateDataFromFirestore(){
        firestore.collection("users").whereField("uid", isEqualTo: userID!).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if querySnapshot!.documents.count == 0 {
                    createUser()
                    firestore.collection("users").whereField("uid", isEqualTo: userID!).getDocuments() { (querySnapshot, err) in
                        userFirestoreDocumentID = querySnapshot!.documents[0].documentID
                    }
                    favoritesFood = []
                    eatenFood = []
                }
                else{
                    let document = querySnapshot!.documents[0]
                    userFirestoreDocumentID = document.documentID
                    favoritesFood = document.data()["favorites"] as! [String]
                    eatenFood = document.data()["eatenFood"] as! [[String: String]]
                }
            }
        }
    }
    
    private static func createUser(){
        let newUser = ["uid": userID!, "favorites": [String](), "eatenFood": [[String: String]]()] as [String : Any]
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
