# zsh-docker-alias


## Intro (TL;DR)

With `zsh-docker-alias` the `rails`, `rake`, and `bundle` commands will first check and see if there's a running docker contianer that mounts the local folder.  If there is it will run the command in the container.  If no containers are found, it runs the command like normal.

    ➜  docker-demo git:(master) ✗ rails test
     📦 intercepted call to rails, running 'docker exec -it docker-demo rails test'
    Run options: --seed 7060

    # Running:

    ....................................................................................................................................

    Finished in 5.156782s, 25.5974 runs/s, 103.9408 assertions/s.
    132 runs, 536 assertions, 0 failures, 0 errors, 0 skips
    Coverage report generated for MiniTest to /app/coverage. 483 / 576 LOC (83.85%) covered.


### Installation


You can either source the `docker-alias.zsh` script directly in your `~/.zshrc` or install it as an Oh My Zsh Plugin

    ln -s $PWD/zsh-plugins/bp-pengie $ZSH_CUSTOM/plugins

    # Next edit ~/.zshrc and update the plugins:
    plugins=(git bundler bp-pengie)



## Limitations

* If you want to auto-execute more commands in docker you need to edit the script directly
* If there are more than one containers that mount the current folder then only the computers know which one it will run in
* It does not work in subdirectories of mounted folders
