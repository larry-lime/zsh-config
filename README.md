# Z-Shell Config

## Installation

### Requirements
- fzf: Command line fuzzy finder
- bat: Cat command replacement
- exa: ls replacement
- ripgrep: better grep replacement
- fd: Intuitive find replacement

#### macOs
Homebrew
```shell
brew install fzf fd exa bat ripgrep
```

#### Ubuntu Linux
fzf
```shell
sudo apt-get install fzf
```

bat
```shell
sudo apt install bat
```

fd
```shell
npm install -g fd-find
```
OR
```shell
cargo install fd-find
```

ripgrep
```shell
cargo install ripgrep
```

exa
```shell
cargo install exa
```

### Config
0. Delete any `~/.config/zsh` directory beforehand
1. `cd ~/.config/ git clone https://github.com/larry-lime/zsh-config zsh`
2. Run `source ~/.config/zsh` to install plugins
3. Restart your terminal
