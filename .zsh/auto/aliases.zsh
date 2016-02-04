alias ls='ls --color=auto'
alias ll='ls --color=auto -l'

alias http-serve='sudo webfsd -R `pwd` -g "$(id -g)" -e 2 -F -l - -4 -p 8000 -d'
