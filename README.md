# News-App-CBA installation guide
1) After downloading project, put Config.xcconfig file inside News-app-CBA/Resources. You can do this from Finder. 
2) Click on root project folder inside xcode. Inside the Project tab, inside the Configurations section, Click the dropdown for both debug and release. Just below both, there should be News-App-CBA, next to each, change the "Based on Configurations File" to Config. This should be the Config file you have just put in Resources. This was what I found usually was able to start running my program
3) While your in the root project folder inside xcode, inside the Targets tab, there should be a section for app icons and launch images, under here, rename Launch Screen File to ListViewController if it is not done so already. 
4) The final thing we can do is to ensure that in the info.plist file, under Information Property List, there should be a variable named API_KEY, with type String, and value $(API_KEY). This should be there by default, but if it is not please contact me or try putting that in yourself first. 


You can also view the four part video tutorial of how I had managed to download and run my project. If all else fails please contact me directly. 
Hope the applicaion works after this!
