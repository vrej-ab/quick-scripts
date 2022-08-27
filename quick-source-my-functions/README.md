# Description
There is a repository named **[quick-functions](https://github.com/vrej-ab/quick-functions)** which contains some functions for `BASH`.

This directory contains scripts that are intended to **clone** the **[quick-functions](https://github.com/vrej-ab/quick-functions)** repository gathering all its functions files in a temporarily file and **source** this file to get those functions in your current **BASH** session.

This will make life easier by
* Having all the usefull user-defined functions in one place/repository accessible from anywhere.
* Being able to quickly implement them in any device running `BASH` in a few steps.

## How to use
If you didn't clone this **[quick-scripts](https://github.com/vrej-ab/quick-scripts)** repository already, simply run the following commands in a line and follow the messages:
```bash
git clone https://github.com/vrej-ab/quick-scripts.git && cd quick-scripts/quick-source-my-functions/ && ./_0_quick-source-functions.sh
```
> This will 
> \* clone the https://github.com/vrej-ab/quick-scripts.git repository
> \* change directory to `quick-scripts/quick-source-my-functions/` - which contains the relevant scripts which will do the job for you.
> \* Run the first script named: `_0_quick-source-functions.sh`

**Or** if you have cloned this **[quick-scripts](https://github.com/vrej-ab/quick-scripts)** repository already, go to `quick-scripts/quick-source-my-functions/` directory and run the first script by:
```bash
./_0_quick-source-functions.sh
```

### Step by step example
Assuming that you are in a clean directory, by running:
```bash
git clone https://github.com/vrej-ab/quick-scripts.git && cd quick-scripts/quick-source-my-functions/ && ./_0_quick-source-functions.sh
```
You will see the following outputs:
```bash
Cloning into 'quick-scripts'...
remote: Enumerating objects: 24, done.
remote: Counting objects: 100% (24/24), done.
remote: Compressing objects: 100% (20/20), done.
remote: Total 24 (delta 1), reused 21 (delta 1), pack-reused 0
Unpacking objects: 100% (24/24), done.
926edd12065d2e9a1343425368f600556cf225d3	HEAD
926edd12065d2e9a1343425368f600556cf225d3	refs/heads/main
c33bdde3c346578c59a205ffd683527d5d630767	refs/pull/1/head
5de873e5d40b0a0dc00849ce75ebab729fb2bce6	refs/pull/2/head
Cloning into 'quick-functions'...
remote: Enumerating objects: 21, done.
remote: Counting objects: 100% (21/21), done.
remote: Compressing objects: 100% (16/16), done.
remote: Total 21 (delta 4), reused 15 (delta 3), pack-reused 0
Unpacking objects: 100% (21/21), done.

[INFO]: Git cloned successfully.

###########################################
#    Please run the following commands    #
# Simply copy each line and paste it in   #
# your terminal                           #
###########################################

declare -F >> "existing-functions-list.tmp"
source new-functions.tmp
declare -F >> "new-functions-list.tmp"
./_1_quick-source-functions-cleanup.sh
```

As stated in the last few lines of the output run the stated commands by copying them and paste them in your terminal:
```bash
declare -F >> "existing-functions-list.tmp"
source new-functions.tmp
declare -F >> "new-functions-list.tmp"
./_1_quick-source-functions-cleanup.sh
```

> `declare -F >> "existing-functions-list.tmp"` # This lists your current shell's existing functions.
> `source new-functions.tmp` # This sources the new functions (prepared by the previous script) to your current shell.
> `declare -F >> "new-functions-list.tmp"` # This lists your current shell’s functions including the new ones.
> `./_1_quick-source-functions-cleanup.sh` # This runs the second script in the current working directory which will provide a **short report** as you can see below and **removes** all the temporarily created files and directories.

Output of the second `./_1_quick-source-functions-cleanup.sh` script is similar to:
```bash
# The following functions are added to your current shell
# If you want to make them permanent add them to your .bashrc file to have them
# on every new session.

_ssh_git
echo_blue
echo_green
echo_red
echo_red_s
my_script_template
```

*Note: The list of added functions may vary depending to the updates on the [quick-functions](https://github.com/vrej-ab/quick-functions) repository that we discussed.*

#### What to do next?
Now you may test these functions in your current shell and may add one or more of them to your `~/.bashrc` file if you'd  like to make them permanent for subsequent new logins/shells.

##### Functions use cases and synopsis
Describing all functions is out of this document's scope, but you may review their code in [quick-functions](https://github.com/vrej-ab/quick-functions) repository online, or run the following command (substituting the `<DESIRED_FUNCTION_NAME>` with the desired function name) in your current shell to get the function's details for review:
```bash
declare -f <DESIRED_FUNCTION_NAME>
```

Like you may pass any message to **echo_red** function as argument and run, this echos your message in **red** color.
Example:
```bash
echo_red Test message
# or put your message string in single-quots if it has special characters
echo_red 'Te$t me$$age!'
```

