# .dotfiles 🏠

> Truly, there's no place like `${HOME}`

This is my dotfiles configuration repository. It uses [dotbot](https://github.com/anishathalye/dotbot) to create
symlinks from `~` to this repository. Running `./install` should not overwrite or remove any existing dotfiles from
your home directory, but will instead warn you that  the file could not be installed when running.


## Initialize

```bash
git clone git@github.com:miklhh/.dotfiles.git && cd .dotfiles
git submodule update --init --recursive
./install
```
