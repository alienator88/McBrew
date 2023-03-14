# McBrew

A fast GUI for Homebrew written in SwiftUI. This is my personal spin on the awesome version from [buresdv](https://github.com/buresdv/Cork).
Adding in features and redesigning the look to fit more of my needs. Also using this as a learning opportunity for Swift as I'm new to it.

## Screenshots

### Dashboard
![Screenshot 2023-03-14 at 1 09 30 PM](https://user-images.githubusercontent.com/6263626/225112653-de40295b-4391-4417-9763-f850634c4ccb.png)
### Packages
![Screenshot 2023-03-14 at 1 09 22 PM](https://user-images.githubusercontent.com/6263626/225112684-4ee7f402-edb8-4de7-abbb-0a10f2863b57.png)
![Screenshot 2023-03-14 at 1 09 49 PM](https://user-images.githubusercontent.com/6263626/225112735-ae912a79-475c-44c2-93d2-bb9b6d6aefab.png)
### Maintenance
![Screenshot 2023-03-14 at 1 09 37 PM](https://user-images.githubusercontent.com/6263626/225112712-32d34114-a665-4054-994a-1330dc58159d.png)
![Screenshot 2023-03-14 at 1 11 12 PM](https://user-images.githubusercontent.com/6263626/225112874-f40aa849-6540-4403-a736-0c2061b4a497.png)
### Settings
![Screenshot 2023-03-14 at 1 10 27 PM](https://user-images.githubusercontent.com/6263626/225112756-52fa227a-3cc5-4dd5-8b4e-f8347f0c38ff.png)
![Screenshot 2023-03-14 at 1 10 39 PM](https://user-images.githubusercontent.com/6263626/225112812-6cfe3a96-a034-4cc9-b4e6-513babb62b1c.png)



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
