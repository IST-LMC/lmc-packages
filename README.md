# LMC Packages

Scripts to build custom packages for the LMC apt repository.

## Usage
Initialize the submodules if not cloned recursively:

    git submodule update --init --recursive

Launch the build VM with Vagrant and run make:

    vagrant up
    vagrant ssh
    cd /vagrant
    make [pubcookie|lmc-python]

Packages will appear in the `deb` directory.

## Submodules
A git submodule always points at the same commit regardless of changes in the parent repository. To update a submodule to most recent commit in a branch do the following:

    cd <submodule>
    git pull origin <branch>

You'll likely also want to bump the version for that package at the top of the `Makefile` and then commit the changes.
