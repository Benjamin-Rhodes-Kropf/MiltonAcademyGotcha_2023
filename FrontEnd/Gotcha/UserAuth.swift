//
//  UserAuth.swift
//  Gotcha
//
//  Created by Blake Ankner on 6/7/22.
//

//
//  UserAuthModel.swift
//  practice
//
//  Created by Tommy Hong on 5/24/22.
//
 
import Foundation
import SwiftUI
import GoogleSignIn
import Firebase
 
class UserAuthModel: ObservableObject {
    
    @Published var givenName: String = ""
    @Published var email: String = ""
    @Published var profilePicUrl: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    @Published var partOfMilton: Bool = false
<<<<<<< Updated upstream
    @Published var inFireBase: Bool = false
=======
    var inFireBase: Bool = false
>>>>>>> Stashed changes
    
    init(){
//        check()
    }
    
    func checkStatus(){ //async
<<<<<<< Updated upstream
//        print("CHECK STATUS CALLED")
=======
>>>>>>> Stashed changes
        if(GIDSignIn.sharedInstance.currentUser != nil){
//            print("CHECK STATUS -- inside IF #1")
            let user = GIDSignIn.sharedInstance.currentUser
            guard let user = user else { return }
            let givenName = user.profile?.givenName
            let email = user.profile?.email
            let profilePicUrl = user.profile!.imageURL(withDimension: 100)!.absoluteString
            self.givenName = givenName ?? ""
            self.email = email ?? ""
            self.profilePicUrl = profilePicUrl
<<<<<<< Updated upstream
            if !self.email.contains("milton.edu"){
=======
            self.isLoggedIn = true
            let check_in_FB = Task{
                let fb_connection = await inDB(uid: "\(self.email)") as! Bool
                if fb_connection == true{
                    inFireBase.toggle()
                }
                inFireBase = fb_connection
                print(inFireBase)
            }
            check_in_FB
            print("\(self.email) containts milton.edu: \(self.email.contains("milton.edu")) || \(self.email) in FB: \(inFireBase)")
//            let fB_connection = await targ(uid: self.email)
            if self.email.contains("milton.edu") && inFireBase{ //&& (fB_connection != "" || fB_connection != nil)
                print("\(self.email) containts milton.edu || \(self.email) in FB: \(inFireBase)")
                self.partOfMilton = true
            }
            else{
>>>>>>> Stashed changes
                self.partOfMilton = false
                self.signOut()
//                print("Signed out -- inside email check (User Auth)")
                return
            }
            Task{
//                print("CHECK STATUS -- inside TASK")
                let fb_connection = await inDB(uid: "\(self.email)") as! Bool
                inFireBase = fb_connection
                print(inFireBase)
                
                if inFireBase{
                    self.isLoggedIn = true
                    self.partOfMilton = true
                }
                else{
                    self.partOfMilton = false
                    self.signOut()
//                    print("Signed out -- inside TASK (User Auth)")
                }
            }
        }
        else{
//            self.signOut()
            print("CHECK STATUS -- inside ELSE #1")
            self.isLoggedIn = false
            self.givenName = "Not Logged In"
            self.email = ""
            self.profilePicUrl =  ""
            self.partOfMilton = false
        }
    }
    
    func check(){
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                self.errorMessage = "error: \(error.localizedDescription)"
            }
            
            self.checkStatus()
        }
    }
    
    func signIn(){
        
       guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
 
        let signInConfig = GIDConfiguration.init(clientID: BuildConfig.googleKey)
        GIDSignIn.sharedInstance.signIn(
            with: signInConfig,
            presenting: presentingViewController,
            callback: { user, error in
                if let error = error {
                    self.errorMessage = "error: \(error.localizedDescription)"
                }
                self.checkStatus()
            }
        )
    }
    
    func signOut(){
        GIDSignIn.sharedInstance.signOut()
        self.checkStatus()
    }
}

