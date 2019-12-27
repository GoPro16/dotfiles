#!/usr/bin/env bash

# executes on exit
trap 'ret=$?; test $ret -ne 0 && printf "\n\e[31m\033[0m  Setup Failed  \e[31m\033[0m\n\n" >&2; exit $ret' EXIT

# Exit immediately if a command exits with a non-zero status
set -e

if [ -e setup-utils.sh ]; then
	. "setup-utils.sh"
else
	printf "\n ⚠️ ./setup-utils.sh not found"
	exit 1
fi

# XCODE
if type xcode-select >&- && xpath=$( xcode-select --print-path ) &&
	test -d "${xpath}" && test -x "${xpath}" ; then
	print_success_muted "Xcode already installed. Skipping."
else
	step "Installing Xcode"
	xcode-select --install
	print_success "Xcode installed!"
fi

# BIN
if [ ! -d "$HOME/.bin/" ]; then
	mkdir "$HOME/.bin"
fi

# NVM (Node Version Manager)
if [ -x nvm ]; then
	step "Installing NVM"
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
	print_success "NVM installed!"
	step "Installing latest Node"
	nvm install node
	nvm use node
	nvm run node --version
	nodev=$(node -v)
	print_success "Using Node $nodev!"
else
	print_success_muted "NVM/Node already installed. Skipping."
fi

# BREW
if ! [ -x "$(command -v brew)" ]; then
	step "Installing Homebrew"
	curl -fsS 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
	export PATH="/usr/local/bin:$PATH"
	print_success "Homebrew installed!"
else
	print_success_muted "Homebrew already installed. Skipping."
fi

# BREW CASK CLEANUP
if brew list | grep -Fq brew-cask; then
	step "Uninstalling old Homebrew-Cask"
	brew uninstall --force brew-cask
	print_success "Homebrew-Cask uninstalled!"
fi

# BREW KEGS
if [ -e $cwd/brew/brew.sh ]; then
	step "Installing Homebrew Formulaes"
  . "brew/brew.sh"
  brew cleanup
fi

# SYMLINK FILES

setup_fish() {

    # create nested directory
    mkdir -p "$HOME/.config/fish/functions"

    # local FILES_TO_SYMLINK=$(find fish -type f -maxdepth 3 | sed -e 's|fish/||')
    local FILES_TO_SYMLINK=$(find fish -type f -maxdepth 3)
    local i=""
    local sourceFile=""
    local targetFile=""

    for i in ${FILES_TO_SYMLINK[@]}; do
        sourceFile="$(pwd)/$i"
        targetFile="$HOME/.config/$i"
        ln -sf "$sourceFile" "$targetFile"
    done

}
setup_fish

# FISHER
step "Installing Fisher Plugin Manager for Fish Shell"
curl --create-dirs --location --output ~/.config/fish/functions/fisher.fish https://git.io/fisher
fish -c fisher
print_success "Fisher installed!"

step "Setup Visual Studio Code Symlink and Plugins"
  sh ./setup-vscode.sh
print_success "Visual Studio Code Setup!"






