//
//  SettingsView.swift
//  DogDash
//
//  Created by Aynin Sheikh on 4/27/25.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var musicVolume: Double = 0.0
    @State private var soundVolume: Double = 0.0
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.orange, .red]),
                startPoint: .bottom,
                endPoint: .top
            )
            .ignoresSafeArea()
            
            VStack {
                
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .frame(width: 300, height: 300)
                        .foregroundColor(.purple)
                    
                    VStack{
                        Text("Settings")
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(Color.green)
                            .font(.system(size: 40, design: .monospaced))
                            .cornerRadius(10)
                        
                        Text("Music")
                            .background(Color.purple)
                            .foregroundColor(Color.green)
                            .font(.system(size: 30, design: .monospaced))
                            .cornerRadius(10)
                        
                        Slider(value: $musicVolume)
                            .accentColor(.red)
                            .frame(width: 250)
                        
                        Text("Sound")
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(Color.green)
                            .font(.system(size: 30, design: .monospaced))
                            .cornerRadius(10)
                        
                        Slider(value: $soundVolume)
                            .accentColor(.red)
                            .frame(width: 250)
                    }// end of second VStack
                    
                    Spacer()
                }// end of second ZStack
                
            }// end of first VStack
                
        }// end of first ZStack
       
    }// end of body
    
}// end of struct

#Preview {
    SettingsView()
}
