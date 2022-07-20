# Script to import and run all . (dot) files
(NOTE bash or terminal compatible)

Tracking for various config/dot files 

**Basic steps to create:**
- initialize git tracked directory (I also set this as .dir just to avoid clutter and keep in ~/)
- copy or move files you wish to track into that directory
- remove those files from ~/ (probably a good idea to make a backup)
- create a symlink file in those locations to the tracked files
- bonus in .bashrc (or an equivalent) create a command that shortcuts to git commands in that tracked dir. this is nice so that if you're in ~/ (home) you can just do > dotFiles stats or > dotFiles commit -a or > dotFiles pull to easily manage the hidden git dirs actual files


Files to date are:
  .vimrc -For vim customizations, shortcuts and configurations
  .vim/  -All supporting .vim files ie colorschemes, scripts, etc
  .bashrc -Bash (and terminal) customizations, aliases, prompt/ script callings, etc
  prompt script (customized to change colors for different svn/git statuses ie, clean is white, dirty is yellow, potential confilct is red, etc)
  svn status colorize script
