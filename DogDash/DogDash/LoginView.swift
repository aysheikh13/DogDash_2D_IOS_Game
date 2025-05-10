//
//  LoginView.swift
//  DogDash
//
//  Created by Aynin Sheikh on 4/27/25.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    @State private var isSuccess:Bool = false
    @State private var isDisabled:Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.orange, .red]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .ignoresSafeArea()
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 50, style: .continuous)
                        .frame(width: 350, height: 500)
                        .foregroundColor(.green)
                        .border(.purple, width:20)
                        .cornerRadius(6)
                    
                    
                    VStack {
                        
                        HStack {
                            Text("Log in")
                                .bold()
                                .padding(.bottom, 40)
                                .font(.system(size: 50, design: .monospaced))
                                .padding(.trailing, 10)
                            
                            Image(systemName: "pawprint.fill")
                                .resizable()
                                .frame(width:50, height: 50)
                                .padding(.bottom, 40)
                        }
                        
                        
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
                        
                        HStack {
                            NavigationLink(destination: ContentView(), isActive: $isSuccess) {
                                Text("Login")
                                    .padding()
                                    .background(Color.purple)
                                    .foregroundColor(Color.green)
                                    .font(.system(size: 30, design: .monospaced))
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        validateNewUser()
                                    }
                            }
                            .disabled(isDisabled)
                            
                            NavigationLink(destination: SignUpView()) {
                                Text("Sign Up")
                                    .padding()
                                    .background(Color.purple)
                                    .foregroundColor(Color.green)
                                    .font(.system(size: 30, design: .monospaced))
                                    .cornerRadius(10)
                            }
                        }
                        .padding()
                        
                        
                    }
                }
            }// end of ZStack
        }
        .navigationBarBackButtonHidden(true)
    } // end of Body
    
    // Validate the user based on the information from the JSON
    func validateNewUser() {
        if let allUsers =  JSONClass.singleInstance.loadUsers() {
            if let user = allUsers.first(where: { $0.username == username && $0.password == password }) {
                JSONClass.singleInstance.setCurrentPlayer(username: username, password: password)
                isSuccess = true
                isDisabled = false
            }
            else {
                isSuccess = false
                isDisabled = true
                presentAlert(withTitle: "Error", message: "No user found!")
            }
        }
        else {
            isSuccess = false
            isDisabled = true
            presentAlert(withTitle: "Error", message: "No user list found!!")
        }
    }
    private func presentAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title:title, message:message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }// end private func
}


#Preview {
    LoginView()
}
