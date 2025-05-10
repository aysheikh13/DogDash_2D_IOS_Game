//
//  CustomizationView.swift
//  DogDash
//
//  Created by Aynin Sheikh on 4/27/25.
//

import SwiftUI

// Customization view that allows the user to pick their own dog and to check their total coins
struct CustomizationView: View {
    
    @State private var isConfirm:Bool = false;
    @State private var dogCost:Int = 0;
    
    var body: some View {
        
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.orange, .red]),
                startPoint: .bottom,
                endPoint: .top
            )
            .ignoresSafeArea()
            

            VStack {
                Rectangle()
                    .padding(.leading, 10)
                    .padding(.bottom, 5)
                    .frame(width: 80, height: 30)
                    .foregroundColor(.blue)
                    .overlay(
                        Image("coinGold")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding(.trailing, 50)
                            .padding(.bottom, 10)
                    )
                    .overlay {
                        Text("\(JSONClass.singleInstance.getPlayerCoins() ?? 5)")
                            .foregroundColor(.white)
                            .font(.system(size: 20, design: .monospaced))
                            .padding(.leading, 40)
                            .cornerRadius(10)
                            
                            
                    }
   
                Text("Choose Your Dog")
                    .bold()
                    .background(Color.purple)
                    .foregroundColor(Color.green)
                    .font(.system(size: 50, design: .monospaced))
                    .cornerRadius(10)
                    .padding(.bottom, 150)
                    

                HStack {
                    
                    Button(action: {
                        isConfirm = true
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.clear)
                                .border(.black, width: 8)
                                .cornerRadius(10)
                                .overlay(
                                    Image("dog1")
                                        .resizable()
                                        .scaledToFit()
                                    
                                )
                        }
                    }
                    
                    
                    Button(action: {
                        isConfirm = true
                        dogCost = 10
                            
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.clear)
                                .border(.black, width: 8)
                                .cornerRadius(10)
                                .overlay(
                                    Image("dog2")
                                        .resizable()
                                        .scaledToFit()
                                    
                                )
                        }
                    }
                    
                    
                    Button(action: {
                        isConfirm = true
                        dogCost = 15

                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.clear)
                                .border(.black, width: 8)
                                .cornerRadius(10)
                                .overlay(
                                    Image("dog3")
                                        .resizable()
                                        .scaledToFit()
                                    
                                )
                        }
                    }
                }
                    
                HStack {
                    Button(action: {
                        isConfirm = true
                        dogCost = 25

                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.clear)
                                .border(.black, width: 8)
                                .cornerRadius(10)
                                .overlay(
                                    Image("dog4")
                                        .resizable()
                                        .scaledToFit()
                                    
                                )
                        }
                    }
                    
                    Button(action: {
                        isConfirm = true
                        dogCost = 30
  
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.clear)
                                .border(.black, width: 8)
                                .cornerRadius(10)
                                .overlay(
                                    Image("dog5")
                                        .resizable()
                                        .scaledToFit()
                                    
                                )
                        }
                    }
                    
                    Button(action: {
                        isConfirm = true
                        dogCost = 35

                    }) {
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.clear)
                                .border(.black, width: 8)
                                .cornerRadius(10)
                                .overlay(
                                    Image("dog6")
                                        .resizable()
                                        .scaledToFit()
                                    
                                )
                            
                        }
                    }
                
                }
                
                HStack {
                    Button(action: {
                        isConfirm = true
                        dogCost = 40

                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.clear)
                                .border(.black, width: 8)
                                .cornerRadius(10)
                                .overlay(
                                    Image("dog7")
                                        .resizable()
                                        .scaledToFit()
                                    
                                )
                        }
                    }
                    
                    Button(action: {
                        isConfirm = true
                        dogCost = 45

                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.clear)
                                .border(.black, width: 8)
                                .cornerRadius(10)
                                .overlay(
                                    Image("dog8")
                                        .resizable()
                                        .scaledToFit()
                                    
                                )
                        }
                    }
                    
                    Button(action: {
                        isConfirm = true
                        dogCost = 50

                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.clear)
                                .border(.black, width: 8)
                                .cornerRadius(10)
                                .overlay(
                                    Image("dog9")
                                        .resizable()
                                        .scaledToFit()
                                    
                                )
                        }
                    }
                
                } // End of HStack

                
            } // End of VStack
            
            if isConfirm {
                Text("\(dogCost)")
                    .padding(.bottom, 190)
                    .foregroundColor(Color.green)
                    .font(.system(size: 30, design: .monospaced))
                    .cornerRadius(10)
                
                Button(action: {
                    if dogCost > JSONClass.singleInstance.getPlayerCoins()! {
                        presentAlert(withTitle: "Oops!", message: "You can't afford this Dog!")
                    }
                    else {
                        JSONClass.singleInstance.updatePlayerCoins(newCoins: -dogCost)
                        JSONClass.singleInstance.updateCurrentDog(newDog: "dog2")
                        presentAlert(withTitle: "Congrats!", message: "Dog has successfully been equiped")
                    }
                }) {
                    Text("Confirm Selection")
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(Color.green)
                        .font(.system(size: 20, design: .monospaced))
                        .cornerRadius(10)
                }
                .padding(.bottom, 80)
            }

        }// End of ZStack
        
    }
    private func presentAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title:title, message:message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }// end private func
}

#Preview {
    CustomizationView()
}
