//
//  SignUpView.swift
//  DogDash
//
//  Created by Aynin Sheikh on 4/27/25.
//

import SwiftUI

struct User: Codable {
    var firstName:String
    var lastName:String
    var email:String
    var username:String
    var password:String
    var coins:Int
    var currentDog:String
    var dogs:[String]
    
    init(firstName: String, lastName: String, email: String, username: String, password: String, coins: Int, currentDog: String, dogs:[String] = []) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.username = username
        self.password = password
        self.coins = coins
        self.currentDog = currentDog
        self.dogs = dogs
    }
}

// Sign up view that contains an authentication adn stores the data inside a pre-establsihed JSON file
struct SignUpView: View {
    
    @State private var firstName     :String = ""
    @State private var lastName      :String = ""
    @State private var email         :String = ""
    @State private var username      :String = ""
    @State private var password      :String = ""
    @State private var rePassword    :String = ""
    
    @State private var isNavigate:Bool = false
    @State private var isSwitch:Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.orange, .red]),
                startPoint: .bottom,
                endPoint: .top
            )
            .ignoresSafeArea()
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 50, style: .continuous)
                    .frame(width: 350, height: 550)
                    .foregroundColor(.green)
                    .border(.purple, width:20)
                    .cornerRadius(6)
                
                
                VStack {
                    
                    HStack {
                        Text("Sign Up")
                            .bold()
                            .padding(.bottom, 40)
                            .font(.system(size: 50, design: .monospaced))
                        
                        Image(systemName: "pawprint.fill")
                            .resizable()
                            .frame(width:50, height: 50)
                            .padding(.bottom, 40)
                    }
                    
                    
                    
                    
                    TextField("", text:$firstName, prompt: Text("Enter First Name").foregroundColor(.blue))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 8)
                        .border(.yellow)
                        .lineLimit(1)
                        .frame(width: 250)
                        .truncationMode(.head)
                        .background(.white)
                        .cornerRadius(8)
                    
                    
                    TextField("", text:$lastName, prompt: Text("Enter Last Name").foregroundColor(.blue))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 8)
                        .border(.yellow)
                        .lineLimit(1)
                        .frame(width: 250)
                        .truncationMode(.head)
                        .background(.white)
                        .cornerRadius(8)
                    
                    
                    TextField("", text:$email, prompt: Text("Enter Email").foregroundColor(.blue))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 8)
                        .border(.yellow)
                        .lineLimit(1)
                        .frame(width: 250)
                        .truncationMode(.head)
                        .background(.white)
                        .cornerRadius(8)
                    
                    
                    TextField("", text:$username, prompt: Text("Enter Username").foregroundColor(.blue))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 8)
                        .border(.yellow)
                        .lineLimit(1)
                        .frame(width: 250)
                        .truncationMode(.head)
                        .background(.white)
                        .cornerRadius(8)
                    
                    
                    SecureField("", text:$password, prompt: Text("Enter Password").foregroundColor(.blue))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 8)
                        .border(.yellow)
                        .lineLimit(1)
                        .frame(width: 250)
                        .truncationMode(.head)
                        .background(.white)
                        .cornerRadius(8)
                    
                    
                    SecureField("", text:$rePassword, prompt: Text("Re-Enter Passowrd").foregroundColor(.blue))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 8)
                        .border(.yellow)
                        .lineLimit(1)
                        .frame(width: 250)
                        .truncationMode(.head)
                        .background(.white)
                        .cornerRadius(8)

                    NavigationLink(destination: LoginView(), isActive: $isNavigate) {
                        Text("Register")
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(Color.green)
                            .font(.system(size: 30, design: .monospaced))
                            .cornerRadius(10)
                            .onTapGesture {
                                validateNewUser()
                            }
                    }
                    .disabled(isSwitch)
                    .padding()
                    
                    // Update score for an existing user
                    //if var existing = UserManager.shared.users.first(where: { $0.name == "Alice" }) {
                    //existing.score += 50
                    //UserManager.shared.addOrUpdateUser(existing)
                    //}
                } // end of VStack
            } // end of ZStack
        }// end of ZStack
    }// end of body
    

    func validateNewUser() {
        if email.count < 5 || !email.contains("@") || !email.contains(".") {
            presentAlert(withTitle: "Invalid", message: "Email is not valid!")
            isNavigate = false
            isSwitch = true
            return
        }
        if username.count < 5 || username.contains(" ") {
            presentAlert(withTitle: "Invalid", message: "Username is not valid!")
            isNavigate = false
            isSwitch = true
            return
        }
        if password != rePassword {
            presentAlert(withTitle: "Invalid", message: "Address is not valid!")
            isNavigate = false
            isSwitch = true
            return
        }
        
        isNavigate = true
        isSwitch = false
        
        let newUser = User(firstName: firstName, lastName: lastName, email: email, username: username, password: password, coins: 0, currentDog: "dog1")
        
        JSONClass.singleInstance.addUser(newUser)

    
        
    }// end func
    
    private func presentAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title:title, message:message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }// end private func
}



#Preview {
    SignUpView()
}
