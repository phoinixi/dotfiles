# Aliases

	`la` - To list all aliases

## Folders & Finder

| Alias     | Description                             |
| --------- | --------------------------------------- |
| `..`      | `cd ..`                                 |
| `~`       | `cd ~.`                                 |
| `w`       | Go to workspace folder                  |
| `f`       | Open finder                              |
| `finder`   | Open finder                              |
| `clean` 	| Delete .DS_Store files                   |

## Utilities

| Alias        | Description                                             |
| ------------ | ------------------------------------------------------- |
| `ip`         | Show your current ip address                            |
| `emptytrash` | Empty the Trash on all mounted volumes and the main HDD |
| `zip`        | Create a zip                                            |
| `kchrome`    | To kill all chrome tabs (stable & canary)               |
| `vscode`     | Open Visual Studio Code                                 |
| `update`     | To update brew and npm                                  |

## Git Aliases

| Alias                   | Description                                       									 		|
| ----------------------- | -----------------------------------------------------------------------	|
| `git c`                 | `git commit -m`                                   									 		|
| `git ca`                | `git commit -am`                                  									 		|
| `git snapshot` 					| `!git stash save "snapshot: $(date)" && git stash apply "stash@{0}"` 		|
| `git snapshots`  				| `!git stash list --grep snapshot`																		 		|
| `git ci`								| `git commit`																		 										 		|
| `git amend` 						| `git commit --amend`            																		 		|
| `git co` 								| `git checkout`																										   		|
| `git cob` 							| `git checkout -b`																												|
| `git d`									| `git diff`																															|
| `git l`									| `git log --graph --date=short`																					|
| `git changes` 					| `git log --pretty=format:\"%h %cr %cn %Cgreen%s%Creset\" --name-status` |
| `git unstage`						| `git reset HEAD`																												|
| `git uncommit`				 	| `git reset --soft HEAD^`																								|
| `git st`								| `git status`																														|
