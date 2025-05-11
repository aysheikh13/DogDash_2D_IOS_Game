# DogDash_2D_IOS_Game

2D IOS Mobile Game developed using Swift and SpriteKit for the Xcode IDE.

## Technologies

The main language used is Swift, along with the imported libraries of Swift UI and SpriteKit to provide the overall GUI of the app, as well as rendering the game scene.

``` Swift
import SwiftUI
import Spritekit
```
Furthermore, this project was built using the Xcode IDE and will only run on it. This is particularly due to XCode's nature in building suitable IOS mobile apps that allow for previews of the IOS device screen and being compatible with Apple's own software architecture.

## Installation & Setup

Installation will require the download of Xcode on a Mac (A Windows machine may be able to do this via a Virtual Machine if you have no other options).

Once installed, open up XCode and simply import the project folder (DogDash). Then, simply press the play button on the top left of the XCode screen to build the app and attach it to the simulator. Note: the project was simulated on an iPhone 13, so it would be preferable to run it on such a model, as it may not be suited to other devices.

## Features & Screenshots

Firstly, we have our login view that allows the user to either create an account via the signup button or log in with their details if their account already exists within the JSON file.

![DogDash1](https://github.com/aysheikh13/DogDash_2D_IOS_Game/blob/main/DogDashScreenshots/dogdash2.png)

Next, we have the main menu that provides an array of different options that the user can choose from, starting with the play button. This button essentially starts the game scene, which you can see in the next screenshot. 

After that, we have the customization button and settings button, along with an exit button, should the user choose to log out or stop playing the game.

![DogDash2](https://github.com/aysheikh13/DogDash_2D_IOS_Game/blob/main/DogDashScreenshots/dogdash3.png)

Here is our gameplay scene where the player on their phone can move the dog up and down by tapping on the dog and allowing the dog to shoot lasers at the enemy UFOs, which can also shoot back. The enemies also drop coins, and a coin counter is displayed at the top.

Moreover, there is a distance label that illustrates the distance made (1 m/s) and a health system where, if the enemy laser comes in contact with the dog, the health bar decreases, as you lose a heart icon. I had to use some bit masking and the SKPhysics to handle collisions and properties of the nodes/objects to make the whole experience interactive. Once you lose all your hearts, I made a game over screen that pauses the game and allows the player to either restart or go to the main menu.

![DogDash3](https://github.com/aysheikh13/DogDash_2D_IOS_Game/blob/main/DogDashScreenshots/dogdash1.png)

Lastly, I wanted to showcase the customization features that allow the user to use their accumulated coins as a way to purchase a new dog that they can flaunt in the game.

![DogDash4](https://github.com/aysheikh13/DogDash_2D_IOS_Game/blob/main/DogDashScreenshots/dogdash4.png)

## Project Status

Complete, however, there is room for improvement in adjusting the GUI or enhancing current features.

## Author

- [@ayninsheikh](https://github.com/aysheikh13)
