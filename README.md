# xyz

xyz simplifies the publishing of npm packages by replacing several manual
steps with a single command:

    $ xyz
    Current version is 0.6.0. Press [enter] to publish example@0.6.1.▌

Several things will happen if one elects to continue:

    node -e 'var o = require("./package.json"); o.version = "0.6.1"; require("fs").writeFileSync("./package.json", JSON.stringify(o, null, 2) + "\n");'
    git add 'package.json'
    git commit --message 'Version 0.6.1'
    git tag --annotate 'v0.6.1' --message 'Version 0.6.1'
    git push origin 'refs/heads/master' 'refs/tags/v0.6.1'
    npm publish

xyz accepts several optional arguments, described in the help text:

    $ xyz --help

### Integration

Installing xyz globally is okay, but it's good practice to add it as a dev
dependency and reference it like so:

    $ node_modules/.bin/xyz

If one is using Make or a similar tool, it's helpful to define aliases for
the various publish commands:

```make
XYZ = node_modules/.bin/xyz --repo git@github.com:owner/repo.git

.PHONY: release-major release-minor release-patch
release-major release-minor release-patch:
	@$(XYZ) --increment $(@:release-%=%)
```

This makes it simple to publish a release of the desired kind:

    $ make release-patch
