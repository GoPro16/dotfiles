alias j=z
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'

alias c="clear"

alias l='exa -la'
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

# alias dog='pygmentize -O style=monokai -f console256 -g'

alias sshkeys="tail +1 ~/.ssh/*.pub"

# git
alias gc='git clone'
alias gp='git pull'
alias gpu='git push'
alias gll='git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn]" --decorate'
alias gl='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'
alias gs='git status -sb'
alias gf='git fetch'
alias gd='git diff'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gco='git checkout'
alias gfo='git fetch origin'
alias gra='git remote add'
alias grr='git remote rm'
alias gbr='git branch -r'
alias gba='git branch -a'
alias pubkey='pbcopy < ~/.ssh/id_rsa.pub'

# iterate through all git repos and show the url
alias gurls='find . -type d -name .git -exec sh -c "cd \"{}\"/../ && git config --get remote.origin.url" \;'
# iterate through all git repos and run `git pull`
alias gua='find . -type d -name .git -exec sh -c "cd \"{}\"/../ && pwd && git pull" \;'
