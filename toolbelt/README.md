# Memes Generator Toolbelt

**MemGenToolbelt** module containt utils functions to simplify managing Memes Generator project.  

### Installation
Module can be installed by coping source files `InstallMemGenToolBelt.ps1` or via symlink creation `InstallMemGenToolBelt.ps1 -ViaSymLink`. Second approach can be useful during development process.

### List of Cmdlests
1. [`Deploy-MGStack`](MemGenToolbelt/functions/Deploy-MGStack.ps1) - create new stack base on current context. Cmdlet waits unit stack creation finish.
2. [`Save-MGStackOutputs`](MemGenToolbelt/functions/Save-MGStackOutputs.ps1) - retrieves stack outputs and saves it to `json` file.
3. [`New-MGKeyPair`](MemGenToolbelt/functions/New-MGKeyPair.ps1) - generates new EC2 key pair base on current contest (`<project>-<stage>-<key-name>` format) and stores it local `.ssh` folder.
4. [`Set-MGContext`](MemGenToolbelt/functions/MGContext.ps1) - helper function used to set context: `project`, `component` and `stage`.