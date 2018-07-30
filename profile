# /etc/profile

# Check for an interactive shell and set umask accordingly. Currently the
# threshold for system-reserved uid/guid's is 200 though you may check
# '/usr/share/doc/setup/uidgid' to confirm this is valid.

case $- in
    *i*) INTERACTIVE="true" ;;

    *)
        if [ "$UID" -gt 199 ] && [ "`id -gn`" = "`id -un`" ]; then
            # Mask current process as a daemon
            umask 002
        else
            # Mask current process as an initscript
            umask 022
        fi

        return
esac

# Gentoo has '/etc/profile.env' which needs to be read. Here we will
# check if it exists and source it if found.

[ -e /etc/profile.env ] &&
    . /etc/profile.env


# Setting PS1 correctly depending on the current shell can be important
# for users of non-standard shells. Here we will attempt to accommodate
# other shells if currently in use, and default to standard shell
# semantics.

if [ -e "$BASH_VERSION" ]; then
    PS1="[\u@\h \W]\$ "
elif [ -e "$ZSH_VERSION" ]; then
    PS1="[%n@%M %d]$ "
else
    PS1="[\u@\h \W]\$ "
fi


# This section defines all PATH and MANPATH locations and is mean to be a
# somewhat exhaustive list for compatibility across various systems. It
# may look quite upsetting but it works for our purposes.

PATH="/usr/local/sbin/:/usr/local/bin:/usr/sbin:/usr/bin:/opt/bin"
PATH="$PATH:/usr/local/gein:/sbin:/bin:$HOME/.local/bin:$HOME/.bin:$HOME/bin"

MANPATH="/usr/man:/usr/share/man:/usr/local/man:/usr/local/share/man"
MANPATH="$MANPATH:$HOME/.local/man:$HOME/.local/share/man"


# This section defines our exports, including the PATH, MANPATH and PS1
# that we defined in previous sections.

export EDITOR="emacs -nw"
export LANG="en_US.UTF-8"
export MANPATH
export PAGER="less"
export PATH
export PROMPT_COMMAND="history -a"
export PS1
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"
export TERM="xterm-256color"


# This section will find and source all files in '/etc/profile.d' that
# end in '.sh'. This is a mechanism to allow the use of multiple files
# that will comprise environment settings or other configurations.

for sh in /etc/profile.d/*.sh; do
    [ -r "$sh" ] &&
        . "$sh"
done


# A $USER may want to maintain local shell configuration files. The
# following section attempts to source '$HOME/.profile' along with all
# files within '$HOME/profile.d' that end in '.sh' similarly to the above
# section.

if [ -d "$HOME"/.profile.d ]; then
    for sh in $HOME/.profile.d/*.sh; do
        [ -r "$sh" ] &&
            . "$sh"
    done
fi


# Keeping things clean in our shell environment is rather important. Here
# we will unset any variables that are no longer needed.

unset sh
