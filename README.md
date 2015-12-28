# Chooser - tool selection manager, like rvm, nvm and perlbrew for everything

## What is chooser?

`chooser` is a tool built on smartcd ( https://github.com/cxreg/smartcd ) that makes it easy to manage multiple versions of all your tools.  When you enter your project directory, your shell is automatically configured to use whatever versions of your tools you have configured.

For example, assume you have a project that uses Ruby and Node.JS.  You have Ruby 2.1.8, 2.2.4 and 2.3.0.  You also have Node.JS 5.3.0 and 4.2.4.

With chooser, simply `cd` to the root of your project directory, and run these commands:

    choose tool ruby v2.1.8
    choose tool node v5.3.0

Now, whenver you enter or leave you project directory, your shell is automatically pointed at the tools you have selected, without changing associations anywhere else on your system.





