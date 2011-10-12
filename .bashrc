#
# ~/.bashrc
#

if [ -x /bin/dircolors ]; then
    [ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
    [ -e "$DIR_COLORS" ] || DIR_COLORS=""
    eval "`dircolors -b $DIR_COLORS`"
fi

color_prompt=yes

# Utils
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias mv='mv -i'
alias cp='cp -i'
alias py2html='pygmentize -f html -O full'
alias pushd="pushd ."
alias mountiso="sudo mount -o loop -t iso9660"
# Mplayer
alias mplayer="mplayer -zoom -vo x11"
# Clipboard
alias xclip="xclip -selection c"
# moving in dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

export EDITOR=vim
export BROWSER=google-chrome
export PYTHONSTARTUP=~/.pythonrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Fancy fancy for git repositories
git.statusline ()
{
    [ -z "$(which git)" ] && return

    CURRENT_BRANCH=$(git branch --no-color 2>/dev/null | sed -n 's/^\* \(.*\)$/\1/p')

    if [ ! -z "$CURRENT_BRANCH" ]; then
        echo -n "{$CURRENT_BRANCH} "
    fi
}

short_cwd ()
{
    # Simpler version using just slices
    # dir=`echo $PWD | sed "s#$HOME#~#"`
    # dirlength=${#dir}

    # if [ "$dirlength" -gt "15" ]; then
    #     dir=${dir:0:10}...${dir:(-10)}
    # fi

    # echo $dir

    BIFS=$IFS; IFS="/"; declare -a Array=(${PWD:1}); IFS=$BIFS

    dir=
    len=${#Array[@]}

    if [ "$len" -gt 5 ]; then

        for ((i=0;i<=1;i++)); do
            dir="$dir/${Array[$i]}";
        done

        dir=$dir/...

        for ((i=$len-2;i<=$len-1;i++)); do
            dir="$dir/${Array[$i]}";
        done
    else
        dir=$PWD
    fi

    dir=`echo $dir | sed "s#$HOME#~#"`
    echo $dir;

}

if [ $(id -u) -eq 0 ]; then
    PS1='$(git.statusline)\[\033[01;31m\]($(short_cwd))\[\033[00m\]: '
else
    PS1='$(git.statusline)\[\033[01;32m\]($(short_cwd))\[\033[00m\]: '
fi
