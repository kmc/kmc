# Kosmos

A simple package manager for Kerbal Space Program. Install any mod by simply
saying `kosmos install name-of-mod`. For example, install Mechjeb by issuing the
command:

```
kosmos install mechjeb
```

*Note:* Kosmos is still in active development, and is not meant for serious use
unless you're brave or stupid.

## Installation

*Note:* Kosmos is indeed not super easy to install if you're not used to
installing things by hand. When Kosmos is ready for "production" use, one-click
installers will be added.

Kosmos has three dependencies, all of which are currently expected to be on your
`PATH`. They are:

* Ruby version 2.0+,
* Git, and
* PhantomJS

### Installing Ruby

Kosmos has been tested on Ruby 2.0.0, and it is recommended that you use Ruby
2.0.0 or greater. Check your version of Ruby using:

```sh
ruby -v
```

If you need to update Ruby, use one of the following tools:

* *Mac*: [RVM](https://rvm.io/) is the recommended tool for the job, but not
  everyone is comfortable with it. If you prefer, you may use
  [Homebrew](http://brew.sh) and install Ruby 2.0 with: `brew install ruby20`.
* *Windows*: Install Ruby 2.0+ with [Ruby Installer](http://rubyinstaller.org/).
* *Linux*: Use [RVM](https://rvm.io/).

Verify that you're running Ruby 2.0+ by running:

```sh
ruby -v
```

### Installing Git

* *Mac*: Use the [Mac Git installer][mac-git], or use Homebrew. Remember to
  check any box asking to add Git to your path.
* *Windows*: Install Git using [this installer][win-git]. Remember to check any
  box asking to add Git to your path.
* *Linux*: Run the command:
  * `yum install git-core` on Fedora, or
  * `apt-get install git` on Debian / Ubuntu.

Verify that Git is installed properly by running:

```sh
git --version
```

### Installing PhantomJS

Install PhantomJS [here][phantom]. You will need to add PhantomJS to your path
manually. Verify that PhantomJS is installed properly by running:

```sh
phantomjs --version
```

### Installing Kosmos itself

Just run:

```sh
gem install kosmos
```

And it'll be ready to go.

## Usage

### First run

First, you have to point Kosmos to your Kerbal Space Program installation directory:

```
kosmos init "your-ksp-path"
```
`your-ksp-path` varies with the operating system and game installation.
For a Steam-installed game it should be:

* on OS X: `kosmos init "~/Library/Application Support/Steam/SteamApps/common/Kerbal Space Program/"`
* on Windows: `kosmos init "C:\Program Files (x86)\Steam\steamapps\common\Kerbal Space Program"`
* on Linux: `kosmos init "~/Steam/SteamApps/common/Kerbal Space Program/"`

Then, Kosmos will be ready to use.

### Mod management

Install any command by running:

```
kosmos install name-of-the-mod-goes-here
```

Uninstall any mod by running:

```
kosmos uninstall name-of-the-mod-goes-here
```

You can install multiple mods by separating the names by spaces:

```
kosmos install mod-a mod-b mod-c
```

You can ask Kosmos what mods it's installed by running:

```
kosmos list
```

### A complete example

Almost all of the mods Scott Manley uses in Interstellar Quest are available
through Kosmos. You can install them all by running:

```
kosmos install active-texture-management b9 kerbal-alarm-clock kw-rocketry ksp-interstellar ferram deadly-reentry kethane infernal-robotics distant-object-enhancement better-atmospheres remote-tech-2 tac-life-support enhanced-navball kerbal-joint-reinforcement docking-port-alignment-indicator safe-chute kerbal-attachment-system real-chute tac-fuel-balancer
```

[mac-git]: http://sourceforge.net/projects/git-osx-installer/
[win-git]: http://git-scm.com/download/win
[phantom]: http://phantomjs.org/download.html
