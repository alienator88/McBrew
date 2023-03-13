# McBrew

A fast GUI for Homebrew written in SwiftUI

## Getting McBrew

Pre-compiled, always up-to-date versions are available from my releases page.

## Screenshots
### Main Window
![Start Page](https://i.imgur.com/N8HQtcL.jpg)

### Package Info
![Package Info](https://i.imgur.com/L7LyzmS.jpg)
![Package Info](https://i.imgur.com/ZHaEcOA.jpg)

### Install Package
![Install Package](https://i.imgur.com/CtqSCUu.jpg)
![Install Package](https://i.imgur.com/Agc7zxX.jpg)

### Tap Taps
![Tap Taps](https://i.imgur.com/Dya1SkM.jpg)

### Brew Maintenance
![Brew Maintenance](https://i.imgur.com/LGkDErZ.jpg)
![Brew Maintenance Results](https://i.imgur.com/GbTerQX.jpg)

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

## License

McBrew is licensed under [Commons Clause](https://commonsclause.com).

This means that McBrew open-source and you can do whatever you want with McBrew's source, like modifying it, contributing to it etc., but you can't sell McBrew or modified versions of it.
