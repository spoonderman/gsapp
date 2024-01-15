### ISSUES
1. Cannot read user data from database in [MainScreen.dart](lib/screens/UserPage/MainScreen.dart) 
and [MainScreenBar.dart](lib/screens/UserPage/MainScreenBar.dart) using FutureBuilder.
Returns null instead of retrieving the corresponding user's data

2. Struggle with displaying updated greenpoints and co2e reductions in [Reward.dart](lib/screens/UserPage/Reward.dart)


### COLORS
green(0xff4eb447)
grey(0xffd2dae2)
black(0xff000000)
white(0xffffffff)
lightgreen(0xff92d36e)

### FLOW OF APP
Wireframe(images/GS_App_Wireframe (2)_page-0001.jpg)

HouseScreen.dart>Register.dart>Login.dart> **MainScreenBar.dart** > **Compost.dart** > **Reward.dart**

**MainScreenBar.dart** is a screen that contains navigation bar and profile drawer which switches 
between MainScreen.dart & Compost.dart

Code is run from [main.dart](lib/main.dart)//ctrl+click main.dart

//Firebase RealtimeDatabase docs
https://firebase.google.com/docs/database/flutter/start?hl=en&authuser=0
firebase_options.dart is part of firebase installation

// Flutter docs
https://docs.flutter.dev/

//curent status of app
[current status of app](current status.txt)

//current database fields
[current database json](compost-19060-default-rtdb-export%20(1).json)





#   g s a p p  
 