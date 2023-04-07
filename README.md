# nvim-lua

This is my Lua configuration for Neovim. It aims to be a relatively lightweight
"IDE layer" over Neovim with sensible defaults and useful keybinds, without
installing any extra or unnecessary plugins.


## Required Setup

A few prerequisite steps are required to function with this configuration. 


### Install Nerd Fonts

Select whatever font you prefer from [the NerdFont
downloads](https://www.nerdfonts.com/font-downloads), and install it. This
provides the icons used by nvim-tree, lsp diagnostics, etc.


### Install [RipGrep](https://github.com/BurntSushi/ripgrep) and [fd](https://github.com/sharkdp/fd)

On macOS, install homebrew and then run `brew install ripgrep fd`. On any other
OS, either install with your package manager of choice or build from source.


### Set OpenAI API Key

If you wish to use the ChatGPT plugin, you must obtain an OpenAI API key, and
set the environment variable `OPENAI_API_KEY=<key>`.


### Install iTerm2 (optional, macOS only)

If you want the theme to render correctly, you must install iTerm2, or some
other terminal with TrueColor support (the default macOS Terminal.app does not
have TrueColor support).


### First Launch

After the first launch, all of the plugins should be installed. For posterity,
also run `:PackerSync` and `:PackerCompile` after first launch.


### Langage Server Installation

To install support for LSP-based suggestions for your language of choice, find
it in the list present [at this
link](https://github.com/neoclide/coc.nvim/wiki/Language-servers) and follow the
directions there. Usually, this just involves running a `:CocInstall` command --
e.g., to install support for `rust-analyzer`, you would run `:CocInstall
coc-rust-analyzer`.


### Updates

Periodically, run `git pull` then `:PackerSync` and `:PackerCompile` in order
to update plugins and any changes to configuration I might have pushed to this repo.


## Useful Keybinds

Convention: `<C-space>` is `Ctrl+Space`, `<C-f>` is `Ctrl+f`, and so on. `<CR>`
is carriage return. `<S-f>` is `Shift+f`, etc.

By default, `<Leader>` is `\`

All keybinds are for normal mode unless otherwise specified.


### Vim General

| Keybind         | Action                                                    |
|-----------------|-----------------------------------------------------------|
| `<C-o>`         | Go back                                                   |
| `jj`            | `<Esc>`                                                   |
| `f<char>`       | Find <char> forward in current line                       |
| `F<char>`       | Find <char> backward in current line                      |
| `s<char><char>` | Find sequence <char><char> forward in current line        |
| `S<char><char>` | Find sequence <char><char> backward in current line       |
| `;`             | Jump to next occurrence (forward or back) in current line |
| `i`             | Enter insert mode (before current character)              |
| `a`             | Enter insert mode (after current character)               |
| `d`             | Delete selected text                                      |
| `c`             | Delete (selected?) text and enter insert mode             |
| `x`             | Delete single character (or selected text)                |
| `v`             | Enter visual mode (highlight mode)                        |
| `V`             | Enter visual line mode (highlight line mode)              |
| `<C-v>`         | Enter visual block mode (block highlight)                 |
| `<S-i>`         | Insert at beginning of selection lines [visual block]     |
| `>>`            | Indent current line                                       |
| `>`             | Indent selection [visual,visual line,visual block]        |
| `<<`            | De-indent current line                                    |
| `<`             | De-indent selection [visual,visual line,visual block]     |
| `gg`            | Go to top of file                                         |
| `G`             | Go to bottom of file                                      |
| `:<line num>`   | Go to line number                                         |


### UI Navigation

| Keybind      | Action                                     |
|--------------|--------------------------------------------|
| `<Leader>tt` | Toggle nvim-tree                           |
| `<Leader>gt` | Focus nvim-tree                            |
| `gb`         | Select tab                                 |
| `<C-w>h`     | Move left one split                        |
| `<C-w>j`     | Move down one split                        |
| `<C-w>k`     | Move up one split                          |
| `<C-w>l`     | Move right one split                       |
| `<S-k>`      | Open documentation for symbol (LSP)        |
| `<Tab>`      | Cycle suggestion forward (LSP) [insert]    |
| `<S-Tab>`    | Cycle suggestion backward (LSP) [insert]   |
| `<CR>`       | Accept suggestion (LSP) [insert]           |
| `<C-f>`      | Scroll popup window forward (LSP) [insert] |
| `<C-b>`      | Scroll popup window back (LSP) [insert]    |
| `<Space>d`   | Open diagnostics list (LSP)                |
| `<Space>e`   | Open extensions list (LSP)                 |
| `<Space>c`   | Open command list (LSP)                    |
| `<Space>o`   | Open outline (LSP)                         |
| `<Space>s`   | Search in symbol list (LSP)                |
| `<Space>j`   | Perform default action for next item (LSP) |
| `<Space>k`   | Perform default actino for prev item (LSP) |
| `<Space>p`   | Re-open last list (LSP)                    |


### Text Navigation

| Keybind      | Action                               |
|--------------|--------------------------------------|
| `gd`         | Go to definition (LSP)               |
| `gy`         | Go to type definition (LSP)          |
| `gi`         | Go to implementation (LSP)           |
| `gr`         | Go to references (LSP)               |
| `[g`         | Go to previous diagnostic item (LSP) |
| `]g`         | Go to next diagnostic item (LSP)     |
| `<Leader>ff` | Find in all project file names      |
| `<Leader>fg` | Find in all project file text       |
| `<Leader>fb` | Find in all open files (buffers)    |
| `<Leader>fh` | Find in all help topics             |


### Text Manipulation

| Keybind      | Action                           |
|--------------|----------------------------------|
| `<Leader>p`  | Paste from system clipboard      |
| `<Leader>y`  | Yank to system clipboard         |
| `<Leader>rn` | Rename symbol (LSP)              |
| `<Leader>rf` | Refactor symbol (LSP)            |
| `<Leader>qf` | Apply quickfix action (LSP)      |
| `<C-space>`  | Trigger completion (LSP)         |
| `<Leader>f`  | Format selected (LSP) [visual]   |
| `<Leader>a`  | Run codeaction (LSP)             |
| `<Leader>re` | Refactor (LSP)                   |
| `<Leader>r`  | Refactor selected (LSP) [visual] |
| `<Leader>cl` | Run CodeLens action (LSP)        |
| `zc`         | Close fold under cursor          |
| `zo`         | Open fold under cursor           |
| `zC`         | Close all folds                  |
| `zR`         | Open all folds                   |


## Plugin List

TBD. Check back later, or just read `lua/plugins/setup.lua`.
