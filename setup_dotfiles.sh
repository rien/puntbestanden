#!/usr/bin/env bash
# Copied with much ❤ from Procrat's setup.sh
# https://github.com/Procrat/dotfiles/blob/master/setup.sh

set -euo pipefail

umask 022

REPO='git@github.com:rien/puntbestanden.git'
DEST="$HOME/puntbestanden/"

# TPM_REPO='https://github.com/tmux-plugins/tpm'
# TPM_DEST="$HOME/.tmux/plugins/tpm"

VIM_PLUG_SCRIPT='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
VIM_PLUG_DEST="$HOME/.config/nvim/autoload/plug.vim"

DEFAULT_SHELL='/bin/zsh'
ZPREZTO_REPO='https://github.com/sorin-ionescu/prezto.git'


ensure_repo_exists_and_has_latest_version() {
    repo="$1"
    dest="$2"
    if [[ -d "$dest" ]]; then
        mkdir -p "$(dirname "$dest")"
        (cd "$dest" && git pull origin)
    else
        git clone "$repo" "$dest"
    fi
}


echo 'Ensuring $HOME/.config exists...'
mkdir -p "$HOME/.config"

echo 'Ensuring repo exist locally...'
ensure_repo_exists_and_has_latest_version "$REPO" "$DEST"

# echo 'Ensuring Tmux Plugin Manager is installed...'
# ensure_repo_exists_and_has_latest_version "$TPM_REPO" "$TPM_DEST"

echo 'Ensuring vim-plug is installed...'
curl -fLo "$VIM_PLUG_DEST" --create-dirs "$VIM_PLUG_SCRIPT"

echo 'Linking dotfiles...'
dotfiles=(
    bash_profile
    bashrc
    config/htop/htoprc
    config/mpv/mpv.conf
    config/nvim/init.vim
    ghci
    gitconfig
    moc/config
    profile
    rubocop.yml
    ssh/config
    tmux.conf
    xinitrc
    xprofile
    Xresources
    zlogin
    zpreztorc
    zprofile
    zshenv
    zshrc
)
for dotfile in "${dotfiles[@]}"; do
    mkdir -p "$(dirname "$HOME/.$dotfile")"
    ln -sfnT "$DEST/$dotfile" "$HOME/.$dotfile"
done

echo 'Fix permissions of .ssh/config'
chmod 644 "$DEST/ssh/config"

echo 'Link Vim config files to NeoVim config files (just to be safe)...'
ln -sfn "$HOME/.config/nvim" "$HOME/.vim"
ln -sfn "$HOME/.config/nvim/init.vim" "$HOME/.vimrc"

echo 'Link bin folder...'
ln -sfn "$DEST/local/bin" "$HOME/.local/bin"

# Really, Freedesktop? There is no hope left if you don't even follow your own
# standards.
#if [[ -e "$HOME/.local/share/applications/mimeapps.list" ]]; then
#    ln -sfn "$HOME/.config/mimeapps.list" \
#        "$HOME/.local/share/applications/mimeapps.list"
#fi

echo "Ensuring $DEFAULT_SHELL is the default shell..."
if [[ -x "$DEFAULT_SHELL" ]]; then
    shell=$(getent passwd "$USER" | cut -d: -f7)
    if [[ "$shell" != "$DEFAULT_SHELL" ]]; then
        chsh -s "$DEFAULT_SHELL"
    fi
    if [[ "$DEFAULT_SHELL" == '/bin/zsh'
        && ! -d '/usr/lib/prezto' && ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]]; then
        git clone --recursive "$ZPREZTO_REPO" "${ZDOTDIR:-$HOME}/.zprezto"
    fi
else
    echo "Shell $DEFAULT_SHELL isn't installed on the system." >&2
fi

echo 'Updating vim-plug and NeoVim plugins...'
if [[ -n "$(which nvim 2>/dev/null)" ]]; then
    nvim --headless +silent! +PlugUpgrade +qall
    nvim --headless +silent! +PlugUpdate +qall
else
    echo 'No NeoVim installation was found.' >&2
fi
