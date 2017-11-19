# xyz

xyz simplifies the publishing of npm packages by replacing several manual
steps with a single command:

    $ xyz
    Current version is 0.6.0. Press [enter] to publish example@0.6.1.▌

Several things will happen if one elects to continue:

    VERSION=0.6.1 node -e "
      var pkg = require('./package.json');
      pkg.version = process.env.VERSION;
      fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2) + '\n');
    "
    git add package.json
    git commit --message 'Version 0.6.1'
    git tag --annotate 'v0.6.1' --message 'Version 0.6.1'
    git push --atomic 'origin' 'refs/heads/master' 'refs/tags/v0.6.1'
    VERSION=0.6.1 PREVIOUS_VERSION=0.6.0 npm publish

xyz accepts several optional arguments, described in the help text:

    $ xyz --help

### Integration

Installing xyz globally is okay, but it's good practice to add it as a dev
dependency.

#### npm

```json
  "scripts": {
    "release": "xyz --repo git@github.com:owner/repo.git --increment",
  }
```

```console
$ npm run release minor
```

#### Make

```make
XYZ = node_modules/.bin/xyz --repo git@github.com:owner/repo.git

.PHONY: release-major release-minor release-patch
release-major release-minor release-patch:
	@$(XYZ) --increment $(@:release-%=%)
```

```console
$ make release-minor
```
