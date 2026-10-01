dotfiles
========

Requirements
------------

- Homebrew
- Zsh

Install
-------

Install [rcm](https://github.com/thoughtbot/rcm):

    brew tap thoughtbot/formulae
    brew install rcm

Install the dotfiles:

    git clone https://github.com/mattdonnelly/dotfiles.git
    ln -s $(pwd)/dotfiles ~/.dotfiles
    env RCRC=$HOME/.dotfiles/rcrc rcup
