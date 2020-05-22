export BASH_PROFILE_LOADED=1
if [ -z "${BASHRC_LOADED}" ]; then
    . ${HOME}/.bashrc
fi