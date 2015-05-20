SAR-HR
======

[![Build status][build-badge]][build]
[![Coverage][coverage-badge]][coverage]

**Backend service for the Social Augmented Reality HR component.**

### Setting up for development ###

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
  $ git clone https://github.com/learning-layers/sar-hr.git
  $ cd sar-hr
  ```

3. Start the Vagrant box using `vagrant up`. This first run will take a few
   minutes, so grab a coffee in the meantime!

4. When done, point your API client to <http://10.11.12.13:9292>. Simples!

### Running commands ###

To run commands within the development environment, use `vagrant ssh`:

```sh-session
$ vagrant ssh   # SSH into the virtual machine
$ cd /vagrant   # Change directory to the project root
$ rake stats    # Do whatever (e.g. show stats about the project)
```

The following commands should be run in the development environment.

#### Serving for development ####

The Vagrant box starts automatically serving the app at
<http://10.11.12.13:9292> when started. It’s an Upstart service:

```sh-session
$ sudo service rails status
```

If you want to do it manually, remember to allow connections from the host. The
easiest way is to bind to `0.0.0.0`.

```sh-session
$ rails s -b 0.0.0.0
```

#### Running tests ####

`rake` is configured to use `rspec` behind the scenes.

```sh-session
$ rake
```

Coverage reports are generated into `./coverage`. They’re static HTML, so you
can just open them in your browser.

### Licence ###

```
The MIT License (MIT)

Copyright © 2015 Aalto University

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

[build-badge]: https://img.shields.io/circleci/project/learning-layers/sar-hr.svg
[build]: https://circleci.com/gh/learning-layers/sar-hr

[coverage-badge]: https://img.shields.io/codecov/c/github/learning-layers/sar-hr.svg
[coverage]: http://codecov.io/github/learning-layers/sar-hr
