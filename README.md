To build and publish a tag:

    ./release.sh <tag>

If the tag is new, you'll have to create a `build/<tag>.sh` file. Just copying the
second-most-recent tag's build file will probably work.

To build and publish an arbitrary commit:

    ./release.sh <sha>

This will run the build file of the tag immediately preceding the commit, and will use the
output of `git describe --tags` as the release name.

Of course, if you don't work at [DataPad](http://datapad.io), you'll have to clone this
repo to run these commands (the script will automatically use the right git endpoint). Pull
requests containing new build files welcome.
