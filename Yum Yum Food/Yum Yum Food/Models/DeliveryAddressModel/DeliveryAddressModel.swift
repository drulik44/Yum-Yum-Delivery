//
//  DeliveryAddressModel.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 25.01.2025.
//


import Foundation
import FirebaseFirestore
import FirebaseAuth
import CoreLocation

class DeliveryAddressModel {
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser

    func saveLocation(coordinate: CLLocationCoordinate2D, completion: @escaping (Bool) -> Void) {
        guard let user = user else {
            completion(false)
            return
        }
        let userRef = db.collection("users").document(user.uid)
        userRef.updateData([
            "latitude": coordinate.latitude,
            "longitude": coordinate.longitude
        ]) { error in
            if let error = error {
                print("Ошибка сохранения местоположения: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Местоположение успешно сохранено в Firestore")
                completion(true)
            }
        }
    }

    func loadSavedLocation(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        guard let user = user else {
            completion(nil)
            return
        }
        let userRef = db.collection("users").document(user.uid)
        userRef.getDocument { (document, error) in
            if let error = error {
                print("Ошибка загрузки местоположения: \(error.localizedDescription)")
                completion(nil)
                return
            }
            if let document = document, document.exists {
                if let latitude = document.data()?["latitude"] as? CLLocationDegrees,
                   let longitude = document.data()?["longitude"] as? CLLocationDegrees {
                    let savedCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    completion(savedCoordinate)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
}