//
//  UserType.swift
//  UberClone
//
//  Created by Fellipe Ricciardi Chiarello on 12/23/20.
//  Copyright © 2020 fchiarello. All rights reserved.
//

import Foundation
import FirebaseDatabase

class UserType {
    public func checkUserType(uid: String) -> String {
        let database = Database.database().reference()
        var type = String()
        let users = database.child(UberConstants.kuser).child(uid)
        users.observeSingleEvent(of: .value) { (snapshot) in
            let data = snapshot.value as? NSDictionary
            let userType = data?[UberConstants.kType] as? String
            type = userType ?? "erro"
        }
        return type
    }
}
