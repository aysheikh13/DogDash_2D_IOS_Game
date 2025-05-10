//
//  ContentView.swift
//  DogDash
//
//  Created by Aynin Sheikh on 4/17/25.
//

import SwiftUI

// Here is tha main ocntent view that essentially serves as the main menu with several functtionalities that allow for the user to switch views
struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.orange, .red]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack {
                    
                    Rectangle()
                        .frame(width: 250, height: 120)
                        .foregroundColor(.purple)
                        .cornerRadius(15)
                        .border(Color.green, width: 3)
                        .blur(radius: 1.5)
                        .overlay {
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 240, height: 250)
                        }
                    
                    Image("dogMain1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .background(Color.clear)
                    
                    NavigationLink(destination: GameplayView()) {
                        Text("PLAY")
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(Color.green)
                            .font(.system(size: 40, design: .monospaced))
                            .cornerRadius(10)
                        
                    }
                    
                    NavigationLink(destination: CustomizationView()) {
                        Text("CUSTOMIZATION")
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(Color.green)
                            .font(.system(size: 40, design: .monospaced))
                            .cornerRadius(10)
                        
                    }
                    
                    NavigationLink(destination: SettingsView()) {
                        Text("SETTINGS")
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(Color.green)
                            .font(.system(size: 40, design: .monospaced))
                            .cornerRadius(10)
                        
                    }
                    NavigationLink(destination: LoginView()) {
                        Text("EXIT")
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(Color.green)
                            .font(.system(size: 50, design: .monospaced))
                            .cornerRadius(10)
                        
                    }
                    
                    
                } // end of VStack
                .padding()
            } // end of ZStack
            .navigationBarBackButtonHidden(true)
            
        }// end of navigation view
        .navigationBarBackButtonHidden(true)
    }// end of body
}// end of struct

#Preview {
    ContentView()
}
