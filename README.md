XCom2 Mod Manager for OSX
----

![Alt text](/docs/demo1.png "Optional Title")

If you have XCom2 for OSX, you might have noticed that mods don't work well, or often at all, and the builtin mod manager takes forever to boot and crashes a lot.

This is an attempt to simplify enabling/disabling mods. Simply start this mod manager and check/uncheck mods to immediately enable/disable them in your mod config.

This has been tested on my machine only; source is included.

Releases
---

Requires [RubyMotion](http://www.rubymotion.com/download/) to build for yourself.

[The latest release can be found here](https://github.com/scally/xcom2-mod-manager/releases).

Caveats
---

It seems that there's been some kind of hotfix that re-enables all installed mods each time you boot the game. I've worked around it for now by setting the file to readonly after we write the list of enabled mods.
