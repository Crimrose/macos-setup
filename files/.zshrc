export LPASS_DISABLE_PINENTRY="1"
export LPASS_AGENT_TIMEOUT="36000"
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}
# Plugin manager
source $HOME/.zsh/zinit/zinit.zsh \
    || (git clone --depth 1 https://github.com/zdharma-continuum/zinit.git $HOME/.zsh/zinit && exec zsh)

# Theme
zinit light-mode depth=1 atload="source $HOME/.p10k.zsh" for romkatv/powerlevel10k

# Plugin list
zinit wait lucid light-mode depth=1 nocd for \
    atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay' zdharma-continuum/fast-syntax-highlighting \
    atload='_zsh_autosuggest_start' zsh-users/zsh-autosuggestions \
    atload='MODE_CURSOR_VIINS="bar"; vim-mode-cursor-init-hook' softmoth/zsh-vim-mode
zinit wait lucid is-snippet for \
    https://github.com/ahmetb/kubectl-aliases/blob/master/.kubectl_aliases \
    https://github.com/ajeetdsouza/zoxide/blob/main/zoxide.plugin.zsh \
    https://github.com/junegunn/fzf/blob/0.52.1/shell/key-bindings.zsh

# Options
setopt \
    autocd \
    autopushd \
    histignorealldups \
    histignorespace \
    sharehistory

# Disable right prompt indent
ZLE_RPROMPT_INDENT=0

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Key bindings
export KEYTIMEOUT=1
bindkey '^[[P' delete-char
bindkey '^?' backward-delete-char
bindkey '^H' backward-kill-word

bindkey -s "^L" 'passag1^M'
# Aliases

# Aliases
export LPASS_DISABLE_PINENTRY=1
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
stop_dns_hell() {
 sudo launchctl unload /Library/LaunchDaemons/com.greenboxal.dnsheaven.plist
 sudo rm -f /etc/resolv.conf
 sudo ln -s /var/run/resolv.conf /etc/resolv.conf
}
start_dns_hell() {
 sudo rm -f /etc/resolv.conf
 sudo launchctl load /Library/LaunchDaemons/com.greenboxal.dnsheaven.plist
}

site () {
	env=${2:-"ag1"}
	case $env in
		(ag1) env=va.main.ag1.axon.us  ;;
		(la1) env=sp.main.la1.axon.io  ;;
		(nl1) env=we.main.nl1.axon.io  ;;
		(us2) env=ca.main.us2.axon.io  ;;
		(us4) env=wa.main.us4.axon.io  ;;
		(eu1) env=ie.main.eu1.axon.io  ;;
		(*) echo "Wrong environment code!"
			return 1 ;;
	esac
	cluster=${3:-"ops"}
	open "https://$1.$cluster.$env"
}

source $HOME/.aliases
