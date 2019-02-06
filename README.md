# dotfiles


## Getting started (Install in OSX)

```sh
git clone https://github.com/phoinixi/dotfiles.git ~/dotfiles && (cd ~/dotfiles && ./install.sh) && rm ~/dotfiles
```

## Features

  - [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh) as your default in terminal

  - [Shortcuts, Aliases](https://github.com/phoinixi/dotfiles/blob/master/docs/Aliases.md)

  - [Homebrew](http://brew.sh/) & [Node.JS](https://nodejs.org/en/)

  - [VSCode Editor](https://github.com/phoinixi/dotfiles/tree/master/vscode) configuration

  - zsh theme (solarized dark) for terminal app

  - [Spectacle](https://www.spectacleapp.com/) basic shortcuts

  - Dark theme OS X and defaults override

  # Aliases

	`la` - To list all aliases

## Folders & Finder

| Alias     | Description                             |
| --------- | --------------------------------------- |
| `..`      | `cd ..`                                 |
| `~`       | `cd ~.`                                 |
| `rm`      | `rm -rf`                                |
| `w`       | Go to workspace folder                  |
| `finder`   | Open finder in the current Folder        |
| `clean` 	| Delete .DS_Store files                   |

## Utilities

| Alias        | Description                                             |
| ------------ | ------------------------------------------------------- |
| `ip`         | Show your current ip address                            |
| `emptytrash` | Empty the Trash on all mounted volumes and the main HDD |
| `zip`        | Create a zip                                            |
| `code`       | Open Visual Studio Code                                 |
| `update`     | To update brew and npm                                  |
| `chrome` 	   | Opens Google chrome                                     |

## Git Aliases

| Alias                   | Description                                       									 		|
| ----------------------- | -----------------------------------------------------------------------	|
| `git c`                 | `git commit -m`                                   									 		|
| `git ca`                | `git commit -am`                                  									 		|
| `git snapshot` 					| `!git stash save "snapshot: $(date)" && git stash apply "stash@{0}"` 		|
| `git snapshots`  				| `!git stash list --grep snapshot`																		 		|
| `git amend` 						| `git commit --amend`            																		 		|
| `git co` 								| `git checkout`																										   		|
| `git cob` 							| `git checkout -b`																												|
| `git d`									| `git diff`																															|
| `git l`									| `git log --graph --date=short`																					|
| `git changes` 					| `git log --pretty=format:\"%h %cr %cn %Cgreen%s%Creset\" --name-status` |
| `git unstage`						| `git reset HEAD`																												|
| `git uncommit`				 	| `git reset --soft HEAD^`																								|
| `git st`								| `git status`																														|



*Found a bug or want a new feature? [create an issue](https://github.com/phoinixi/dotfiles/issues/new)*
