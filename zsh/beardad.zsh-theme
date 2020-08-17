PS1='%{$fg_bold[cyan]%}%n%{$reset_color%}$FG[105] @%{$fg[blue]%}%m %{$fg_bold[green]%}:%d%{$fg_bold[yellow]%} %D{[%H:%M:%S]}
%{$fg[blue]%}[%{$reset_color%}$FG[105]%(!.#.$)%{$fg_bold[blue]%}] %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
