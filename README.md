

iPad video: 
Low-resolution video: https://drive.google.com/file/d/1bdaEU0pj9AnMwuF7s0r3VbvfwF3Mucp9/view?usp=sharing
High-resolution video: https://drive.google.com/file/d/1V9YzrvcWSwN9qTXKE46UVg-b3AX3K1Uy/view?usp=sharing


iPhone video: 
Low-resolution video: https://drive.google.com/file/d/10eIF8MjY29rjjcyMp4XcOatblXThfisB/view?usp=sharing
High-resolution video: https://drive.google.com/file/d/1rPrbhFX05wJ-6FXNjhya6yz2wczhaZjz/view?usp=sharing








**Listed all the application features as below** 

------------------------------------------------

**Basic Info** 

Design Pattern used is MVVM
Xcode Version 12.5.1 (12E507)
iOS version 13.0
Covered test cases for all the calculation part with the  viewModel
Integrated  swiftlint to following swift coding standards
Git setup for project with gitignore file 


**Technologies**
 - Swift 
- iOS Frameworks 
- GIT 
- Firebase SDKs for crashlytics 
- For UI used size-classes (iPhone and iPad)
- SPM (Swift Package Manager) for third party library 
- Pod integration for Firebase, SwiftLint 




**------------------------------------------------Functional Requirements covered------------------------------------------------**

**REQ. 1. User Interface covered**
The interface will work for  iPhone devices and iPads, and for all orientation and device size. Used size classes for this

**REQ. 2. Basic operations covered**
The calculator has following operations, which does not require any online call. 


**Symbol Operation Example**

addition 2 + 2 = 4

subtraction 5 - 7 = -2

multiplication 6 * 2 = 12
 
division 20 / 5 = 4

sin (degrees) sin(90) = 1

cos (degrees) cos(360) = 1



**REQ. 3. Online operations covered**

The calculator have the online operation, which requires online calls 
 Below api used just to accomplish the operation showcase, for USD it will calculate BTC value 
//https://blockchain.info/tobtc?currency=USD&value=144

Given USD $ value $500 and it will calculate BTC value = USD(500) = 0.01027163




**REQ. 4. Feature toggling covered**
You can enable or disable features for this calculator. For instance, if an operation such as addition [ + ] is not needed, you can disable it. The code supports this feature. As well, the UI automatically distributes its components based on feature toggling.



**REQ. 5. Error feedback covered**
The user will be able to receive friendly feedback for errors (for example, if an online operator fails due to connectivity). 


**REQ. 6. Concatenate operations covered**


The user can do concatenate operations.


● Type 2 
● Type + 
● Type 3 
● Result = 5 
● Type * 
● Type 4 
● Result = 20 





**------------------------------------------------Non-Functional Requirements covered------------------------------------------------**

**NREQ. 1. Color Schemes covered**
The app supports two kinds of color themes. If we wish to change the colors of the app and its components, we should be able to do it by switching a single feature. 

**NREQ. 2. Modularization covered**
Distributed app in modules

**NREQ. 3. Error Handling covered**
Error Handling in your application to report problems. 






**------------------------------------------------Optional requirements  Requirements covered------------------------------------------------**

OPT. 1. Offline mode covered

OPT. 3. Crashlytics using Firebase

