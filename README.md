# neovim-dotfiles
Dotfiles for Neovim used by Mengano.Net

# How to install
If you have existing Neovim configuration you must first get rid of it, by doing the following:
- Clear/backup the following directories:
  - `~/.config/nvim/`
  - `~/.cache/nvim/`
  - `~/.local/share/nvim/`
- Get a release version [i.e. v 
  1.3.0](https://github.com/mengano-net/neovim-dotfiles/releases/tag/1.3.0)
- Copy all contents into your `~/.config/nvim/`

# Starting Neovim
- The first time you launch, Neovim will dump errors, primarily due to not having `Packer` 
  installed, which is a plug-ins manager. Just give it 1 minute for Neovim to install it, then quit 
  Neovim.
- Re-launch Neovim; the first thing is to run Packer to install all necessary plugins: you do it by 
  running `PackerSync` Neovim command as shown on screenshot below.

# How to use
- First you need to know some basics of vim operations that I'm not covering here.
- One of the plugins I use manages key maps(key combinations performing some actions). _Most_ key 
  combinations need a `leader` key to start them, in my case, it's `space` key
