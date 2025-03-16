#!/bin/bash
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
export load_conda=1
__conda_setup="$('/home/vahid2/anaconda3_2024/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $load_conda -eq 1 ]; then 
        if [ $? -eq 0 ]; then
            echo "Conda Setup"
            eval "$__conda_setup"
        else
            if [ -f "/home/vahid2/anaconda3_2024/etc/profile.d/conda.sh" ]; then
                . "/home/vahid2/anaconda3_2024/etc/profile.d/conda.sh"
            else
                export PATH="/home/vahid2/anaconda3_2024/bin:$PATH"
            fi
        fi
        unset __conda_setup
fi  
# <<< conda initialize <<<a
