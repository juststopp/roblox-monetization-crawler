# roblox-monetization-crawler

Two bash scripts that can be used to images of products or gamepasses from an experience you **have access** to.

## How it works ?

1. Grab you Roblox session cookie. https://create.roblox.com -> Right-Click -> Inspect -> Network -> CTRL + R (Reload page) -> try to find a request where the cookies in the headers look like this: `GuestData=UserID=-....; RBXEventTrackerV2=CreateDate=4/9/2024 2:15:26 AM&rbxid=4975269123&browserid=...; _gid=GA1.2.2095106453.1716190755; RBXSessionTracker=sessionid=...; .ROBLOSECURITY=_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this-will-allow-someone-to-log-in-as-you-and-to-steal-your-ROBUX-and-items.|.....` **DO NOT SHARE THIS COOKIE!**
2. Clone this repo
3. In a terminal, navigate to the repo folder
4. Export your session cookie: `export ROBLOX_COOKIE=YOUR_COOKIE_HERE`
5. Run one of the two scripts: `sh gamepasses.sh SAVE_FOLDER EXPERIENCE_ID` or `sh products.sh SAVE_FOLDER EXPERIENCE_ID`
