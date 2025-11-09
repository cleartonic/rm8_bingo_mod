## RM8 Bingo Mod

Features:
- Immediate game start to stage select
- All 8 Robot Master, Duo and Wily stages selectable
- Wily stage will give all Robot Master weapons and Rush items


# Usage
** UPDATE YOUR EMULATORS TO THE LATEST VERSION!! **  
Due to nature of applying patches for PSX games, and that most Rockman 8 ISO files are split, you must first combine your ISO (typically 4 tracks) into one file. The steps to patch are below:

- Combine your Rockman 8 local copy with [psx-comBINe](https://github.com/ADBeta/psx-comBINe) into one .bin file, and save in a temporary folder.
- Download this codebase as a zip and extract to a folder
- Create a `/bin` folder in this root folder
- Place "Rockman 8 - Metal Heroes (Japan).bin" and "Rockman 8 - Metal Heroes (Japan).cue", that you created in step 1, in the root folder. 
- Run `make.bat`. You can either double click on this file, or you can type `cmd` into the Explorer bar, press Enter, then type `make.bat` and press Enter. The output will be placed in `/bin`.
** UPDATE YOUR EMULATORS TO THE LATEST VERSION!! **  

# Troubleshooting
If you want to confirm the before & after files are correct, do the following (on Windows):  
- Open Windows Explorer, navigate to the folder where your RM7 ROMs are  
- Shift + Right Click > "Open PowerShell window here"  
- In Powershell, use the following command, substituting the [file] with your file name: `CertUtil -hashfile '[file]' md5`  
- The source `Rockman 8 - Metal Heroes (Japan).bin` file should return the following hash: `df7a2a86be8658b1528c265070e3749e`  
- The patched `bin\Rockman8_Bingo.bin` file should return the following hash: `2bed4f58fefa8077ffdd5f71d1c3592a`  

Confirmed emulators: duckstation, bizhawk

# Known issues
- Duo does not load in Duo stage
- When hovering over the Wily stage, only the "W" appears and not the castle icon, implying the stage is not yet unlocked, but it is unlocked