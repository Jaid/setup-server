#!/usr/bin/env bash
set -o errexit

gitClone dylanaraps/neofetch

# echo -e "\nnerd_font=on bash ~/src/neofetch/neofetch --title_fqdn on --kernel_shorthand on --memory_percent on --memory_unit gib --cpu_temp C --underline_char  --kernel_shorthand off --block_width 4 --memory_display on --cpu_cores physical --speed_shorthand on" | tee -a ~/.zshrc

installGist ba4ebe46f1dea42972b912747feb9365
