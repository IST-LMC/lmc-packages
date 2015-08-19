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
