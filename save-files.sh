#!/bin/bash

cp ~/.zshrc ./.zshrc
cp ~/.vimrc ./.vimrc
cp ~/.gnupg/gpg.conf ./.gnupg/gpg.conf
cp ~/.gnupg/gpg-agent.conf ./.gnupg/gpg-agent.conf
cp ~/.config/nvim/* -r ./.config/nvim/
cp ~/.config/nvim/.stylua.toml ./.config/nvim/
cp ~/.config/nvim/.gitignore ./.config/nvim/
rm ./.config/nvim/lazy-lock.json
cp ~/.config/rustfmt/rustfmt.toml ./.config/rustfmt/rustfmt.toml
cp ~/.config/Google/AndroidStudio2023.3/studio64.vmoptions ./.config/Google/AndroidStudio2023.3/studio64.vmoptions
