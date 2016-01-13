# Choose - The Universal Version Manager

## What is choose?

`choose` is a universal version manager.  Use it to automatically configure tool choice for your projects.  It uses smartcd ( https://github.com/cxreg/smartcd ) to automatically configure your editors, interpreters, and environment for each of your projects.

For example, assume you have a project that uses Ruby and Node.JS.  You have Ruby 2.1.8, 2.2.4 and 2.3.0.  You also have Node.JS 5.3.0 and 4.2.4.

With `choose`, simply `cd` to the root of your project directory, and run these commands:

    choose tool ruby v2.1.8
    choose tool node v5.3.0

Now, whenver you enter or leave you project directory, your shell is automatically pointed at the tools you have selected, without changing associations anywhere else on your system.

Thanks to the miracle of bash tab completion, you don't even need to remember what tools and versions are available.  Just hit tab to see a list of available options.


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

## Mode of Operation

### Default Configuration

Running the `choose tool` command writes a `.choose` file into the current directory and installs the smartcd template `chooser` on the directory.  There may be multiple `.choose` files, as each tool gets its own


By default `choose` adds `$CHOOSE_BASE/tools/$TOOL/$VERSION/bin` to `$PATH`

## Custom Tool Scripts

It is possible to provide custom behaviors for each tool or version of a tool on your system.  `choose` supports custom behavior for `select`, `deselect`, and `build`.

### Select and Deselect

When you enter a directory with tool choice configured, (through the `choose tool <tool> <version>` command), the tool's `select` smartcd script is executed.  When you leave that directory, the tool's `deselect` smartcd script is executed.

Create a select or deselect script by writing a file called choose.select (or deselect, as apropriate) into the tool's source or install directory.  You can override for a specific version of your tool, by putting one in the version's source or install directory.  Version specific scripts replace tool scripts.

### Build ###

A build script is an executable command that is executed when `choose build <tool> <version>` is executed.  The environment variables `$TOOL`, `$VERSION`, and `$CHOOSE_ROOT` are set.

A typical build script will download a source tarball, unpack it, and run `make` and `make install.


