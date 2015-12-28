# Chooser - tool selection manager, like rvm, nvm and perlbrew for everything

## What is chooser?

`chooser` is a tool built on smartcd ( https://github.com/cxreg/smartcd ) that makes it easy to manage multiple versions of all your tools.  When you enter your project directory, your shell is automatically configured to use whatever versions of your tools you have configured.

For example, assume you have a project that uses Ruby and Node.JS.  You have Ruby 2.1.8, 2.2.4 and 2.3.0.  You also have Node.JS 5.3.0 and 4.2.4.

With chooser, simply `cd` to the root of your project directory, and run these commands:

    choose tool ruby v2.1.8
    choose tool node v5.3.0

Now, whenver you enter or leave you project directory, your shell is automatically pointed at the tools you have selected, without changing associations anywhere else on your system.


## Installation

1. Make sure you have smartcd installed.
2. Clone this repo
3. Run these commands:

  make install
  mkdir -p $HOME/choose/tools
  mkdir -p $HOME/choose/src
  load_choose
  echo '[ -r "$HOME/.choose/load_choose" ] && source ~/.choose/load_choose' >> $HOME/.bashrc

## General usage

* Keep your source files under `~/choose/src`
  - totally optional at this point I don't have any nifty tools to help with builds -- yet.
* Keep your tools under `~/choose/tools`.


For this example directory structure:

    ~/choose/src/
    ~/choose/tools/
      |- perl
      |   |- perl-5.14.3
      |   `- perl-5.20.2
      `- node
          |-node-0.10.13
          `-node-0.11.14

Choose will give these results:

    >choose list tools
    perl
    node

    >choose list versions node
    node-0.10.13
    node-0.11.14

    >choose tool node node-0.11.1
    Configuring `/home/user/.smartcd/scripts/home/user/Documents/hiring/bash_enter from template chooser
    Configuring /home/user/.smartcd/scripts/home/user/Documents/hiring/bash_leave from template chooser

