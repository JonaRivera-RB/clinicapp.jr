//
//  AuthService.swift
//  redSocial
//
//  Created by misael rivera on 03/03/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    func registerUser(with email:String, andPassword password:String, userCreationComplete:@escaping(_ status:Bool, _ error:Error?) -> () ) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard user != nil else {
                userCreationComplete(false, error)
                return
            }
          /*  let userData = ["provider": user.providerID,
                            "email": user.email,
                            "id": user.uid]
            DataService.instance.createDBUser(uid: user.uid, userData: userData as Any as! Dictionary<String, Any>)
 */
            userCreationComplete(true, nil)
        }
    }
    
    func loginUser(with email:String, andPassword password:String, loginComplete:@escaping(_ status:Bool, _ error:Error?) -> () ) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                loginComplete(false, error)
                return
            }
            loginComplete(true, nil)
        }
    }
}
