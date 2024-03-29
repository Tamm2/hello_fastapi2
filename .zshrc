
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/ikuto/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/ikuto/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/ikuto/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/ikuto/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="$PATH:[PATH_TO_FLUTTER]/flutter/bin"
export PATH="$PATH:[PATH_TO_FLUTTER]/flutter/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$HOME/Library/Python/3.8/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin"
export PATH=$HOME/.local/bin:$PATH
eval $(/opt/homebrew/bin/brew shellenv)
export PATH=$PATH:/Users/ikuto/Desktop/創作export PATH="$PATH:/path/to/ngrok"
export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:/Users/ikuto/Library/Python/3.9/bin"
