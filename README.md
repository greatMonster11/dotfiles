## My dot file configuration for my work place ....
This would be updated regularly :)

### MUST USE NEOVIM 5x !!!

![preview]

[preview]: https://github.com/greatMonster11/dot-file/blob/master/screen.png "TheGreatMonster11"

## Drag-and-drop Configuration

To use this configuration for your own personal use (recommended):

1. Install `neovim` latest using the instructions at https://github.com/neovim/neovim

3. Install `ripgrep` latest using the instructions at https://github.com/BurntSushi/ripgrep

4. Install `vim-plug` (required for plugins management) using the instructions at https://github.com/junegunn/vim-plug

5. Copy `init.vim` to the local Neovim config path:

> NOTE: The default Neovim config path is used below but may vary depending on installation method.

```
mkdir -p ~/.config/nvim/
cp init.vim ~/.config/nvim/init.vim
```

4. Install `plugins` for Neovim using headless operation:

```
nvim --headless +PlugInstall +qa
```

This last step can also be achieved using `:PlugInstall` after opening Neovim - however it will require a restart for them to properly load.
