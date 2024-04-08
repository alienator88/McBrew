# McBrew

<img src="https://user-images.githubusercontent.com/6263626/225120744-5e820fc6-2932-44dc-8b62-aa613542fad8.png" width="100" height="100">

A fast GUI for Homebrew written in SwiftUI. This is my personal spin on the awesome version from [buresdv](https://github.com/buresdv/Cork). 
Adding in features and redesigning the look to fit more of my needs. Also using this as a learning opportunity for Swift as I'm new to it.

## Changes from the fork
- Revamped dashboard
- Button to go back to dashboard
- Split out some of the toolbar buttons to upgrade brew and packages independently if desired
- Analytics toggle on card
- Brew version on dash
- Brew health on dash
- Package/tap icons
- Show formulae/cask/tap count in sidebar and menu bar
- This fork leans more towards UI changes rather than functionality



## Screenshots

### Dashboard
![Screenshot 2023-03-17 at 4 05 59 PM](https://user-images.githubusercontent.com/6263626/226061679-8193f2ba-9292-4675-bce7-c1a684287b3d.png)
![Screenshot 2023-03-17 at 4 06 04 PM](https://user-images.githubusercontent.com/6263626/226061689-d0d87ef7-ac1f-49a3-a276-2a9da1810505.png)
### Packages
![Screenshot 2023-03-17 at 4 06 25 PM](https://user-images.githubusercontent.com/6263626/226061698-9d49697c-41b4-4514-a6cf-050c79f1db67.png)
![Screenshot 2023-03-17 at 4 06 54 PM](https://user-images.githubusercontent.com/6263626/226061713-938ab838-be8b-4bcd-b9fe-7e44e57a17a7.png)
### Maintenance
![Screenshot 2023-03-17 at 4 07 02 PM](https://user-images.githubusercontent.com/6263626/226061720-7c452062-4245-4ac9-b88a-fa34bcea192a.png)
![Screenshot 2023-03-17 at 4 07 17 PM](https://user-images.githubusercontent.com/6263626/226061738-238a5a72-4ace-4ed8-b86b-142e3f5d4bfe.png)
### Settings
![Screenshot 2023-03-17 at 4 07 32 PM](https://user-images.githubusercontent.com/6263626/226061749-db3a9a4c-f371-4302-9ca0-f7b59ac5684d.png)
![Screenshot 2023-03-17 at 4 07 56 PM](https://user-images.githubusercontent.com/6263626/226061755-55968d3b-72a3-4d53-8a13-2e4771f9d873.png)
![Drop](https://user-images.githubusercontent.com/6263626/225772842-51344716-543d-4868-9ff5-456ec562b96f.png)




## Getting McBrew

Pre-compiled, always up-to-date versions are available from my releases page. (See compilation instructions below)

You'll need to run this before opening the app as I don't have a paid developer account: 

`sudo xattr -r -d com.apple.quarantine "PATH_TO_APP"`

## Compiling McBrew

Compiling McBrew is simple, as it does not have many dependencies.

Prerequisites:

* macOS Ventura or newer
* Xcode 14.2 or newer
* Git
* An Apple Developer accout. **You don't need a paid one! Even a free one works perfectly**

Instructions:

**Before you begin**

0. Enroll your account in the developer program at [https://developer.apple.com/](https://developer.apple.com/)
1. Install Xcode
2. Add your Developer account to Xcode. To do so, in the Menu bar, click `Xcode → Settings`, and in the window that opens, click `Accounts`. You can add your account there
3. After you add your account, it will appear in the list of Apple IDs on the left od the screen. Select your account there
4. At the bottom of the screen, click `Manage Certificates...`
5. On the bottom left, click the **+** icon and select `Apple Development`
6. When a new item appears in the list called `Apple Development Certificates`, you can press `Done` to close the account manager

**Compiling McBrew**

1. Clone this repo using `git clone https://github.com/alienator88/McBrew.git && cd McBrew && open .`
2. Double-click `McBrew.xcodeproj`. Xcode should open the project
3. Wait until all the dependencies are resolved. It should take a couple minutes at most
4. In the Menu Bar, click `Product → Archive` and wait for the building to finish
5. A new window will open. From the list of McBrew rows, select the topmost one, and click `Distribute App`
6. Click `Copy App`
7. Open the resulting folder. You'll see an app called McBrew. Drag McBrew to your `/Applications/` folder, and you're done!

## Thanks

Much appreciation for the original, Cork, from https://github.com/buresdv

## License

McBrew is licensed under [Commons Clause](https://commonsclause.com).

This means that McBrew open-source and you can do whatever you want with McBrew's source, like modifying it, contributing to it etc., but you can't sell McBrew or modified versions of it.

## Some of my apps

[Pearcleaner](https://github.com/alienator88/Pearcleaner) - An opensource app cleaner with privacy in mind

[Sentinel](https://github.com/alienator88/Sentinel) - A GUI for controlling gatekeeper status on your mac

[Viz](https://github.com/alienator88/Viz) - Utility for extracting text from images, videos, qr/barcodes

[McBrew](https://github.com/alienator88/McBrew) - A GUI for managing your homebrew
