Heureka
=======

**Backend service for the Social Augmented Reality HR component.**

Still being worked on. Lots of small parts and sharp corners.

Setting up for development
--------------------------

Vagrant makes this easy peasy lemon squeezy by creating and configuring a
virtual Linux guest on your development machine.

1. If you haven’t already, install [Vagrant](https://www.vagrantup.com) and
   [VirtualBox](https://www.virtualbox.org). The easiest way on OS X is to use
   [Homebrew Cask](http://caskroom.io):

   ```sh-session
   $ brew cask install vagrant virtualbox
   ```

2. Clone the repository and `cd` into it:

  ```sh-session
  $ git clone https://github.com/lnikkila/heureka.git
  $ cd heureka
  ```

3. Start the Vagrant box using `vagrant up`. This first run will take a few
   minutes, so grab a coffee in the meantime!

4. When done, point your API client to <http://10.11.12.13:9292>. Simples!
