# .dotfiles 🏠

My dotfiles repository. [Dotbot](https://github.com/anishathalye/dotbot) is used to create symlinks from `${HOME}` to
this directory by running the `./install` shell script. Running `./install` will not overwrite or remove any
existing configuration from the home directory and will instead warn that one or more files can not be symlinked while
executing.

> *Look again at that dot. That's here. That's home. That's us.* 🌍  
> \- Arvid Larsson  
> \- - Erik Bjäreholt  
> \- - - Carl Sagan


## Initialize

```bash
git clone git@github.com:miklhh/.dotfiles.git
cd .dotfiles
git submodule update --init --recursive
./install
```
