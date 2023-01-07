# Z-Shell Config

## Installation

### Requirements
- [fzf](https://github.com/junegunn/fzf): Command line fuzzy finder
- [bat](https://github.com/sharkdp/bat): Cat command replacement
- [exa](https://github.com/ogham/exa): ls replacement
- [ripgrep](https://github.com/BurntSushi/ripgrep): better grep replacement
- [fd](https://github.com/sharkdp/fd): Intuitive find alternative

#### macOs
Homebrew
```shell
brew install fzf bat ripgrep exa gh
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
1. Git clone configuration repo
    ```shell
    cd ~/.config/ && git clone https://github.com/larry-lime/zsh-config zsh
    ```
2. Source config to install plugins
    ```shell
    source ~/.config/zsh
    ```
3. Restart your terminal
