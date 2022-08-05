# Tfux

This document will explain how each part of Tfux works.

Tfux is a file finder plugin written in shell script. 

```bash
#!/usr/bin/zsh

FILEPATH=$(find ~/projects/ -not -path '*/\.git/*'\
  | fzf
    --expect "alt-enter,enter" \
    --height 100% \
    --preview 'if [ -d {} ]; then tree -C {}; else batcat --style=numbers --color=always --line-range :500 {};fi' \
  | xargs echo)
```

First, we use the built in find function to output all files and directories in the `~/projects` directory. We pipe that output into fzf, expecting alt-enter and enter as key presses. For fzf's preview, we use `tree` to display the directory tree structure (if `$FILEPATH` is a directory) and `batcat` to display the file contents (if `FILEPATH` is a ) file.

```shell
read -r ACTION SELECTION <<< "${FILEPATH}" # Assign $FILEPATH to $SELECTION

if [ -z $SELECTION ]; then # If $SELECTION does not exist
  exit 0
fi

FILE=$(basename $SELECTION)
DIR_PATH=$(dirname $SELECTION)
PARENT_DIR=$(basename $DIR_PATH | tr -d '.')
```

Next, we assign the output of `$FILEPATH` to `$SELECTION`, and exit if it's a null value. Then we declare a few important global variables.

Eg. if `$SELECTION` is equal to `'/home/user/.config/init.lua'`

* `$FILE` is equal to `'init.lua'`''
* `$DIR_PATH` is equal to `'/home/user/.config'`
* `PARENT_DIR` is equal to `'config'`
