# xyz

xyz simplifies the publishing of npm packages by replacing several manual
steps with a single command:

    $ xyz
    Current version is 0.6.0. Press [enter] to publish example@0.6.1.▌

Several things will happen if one elects to continue:

    npm prune
    npm test
    env VERSION=0.6.1 node -e '
      var pkg = require("./package.json");
      pkg.version = process.env.VERSION;
      fs.writeFileSync("package.json", JSON.stringify(pkg, null, 2) + "\n");
    '
    git add package.json
    git commit --message 'Version 0.6.1'
    git tag --annotate v0.6.1 --message 'Version 0.6.1'
    git push --atomic origin refs/heads/master refs/tags/v0.6.1
    env VERSION=0.6.1 PREVIOUS_VERSION=0.6.0 bash -c 'npm publish'

## Usage

    Usage: xyz [options]

    Publish a new version of the npm package in the current working directory.
    This involves updating the version number in package.json, committing this
    change (along with any staged changes), tagging the commit, pushing to the
    remote git repository, and finally publishing to the public npm registry.

    Options:

    -b --branch <name>
            Specify the branch from which new versions must be published.
            xyz aborts if run from any other branch to prevent accidental
            publication of feature branches. 'master' is assumed if this
            option is omitted.

    -e --edit
            Allow the commit message to be edited before the commit is made.

    -i --increment <level>
            Specify the level of the current version number to increment.
            Valid levels: 'major', 'minor', 'patch', 'premajor', 'preminor',
            'prepatch', and 'prerelease'. 'patch' is assumed if this option
            is omitted.

    -m --message <template>
            Specify the format of the commit (and tag) message.
            'X.Y.Z' acts as a placeholder for the version number.
            'Version X.Y.Z' is assumed if this option is omitted.

       --prerelease-label <label>
            Specify the label to be used in the version number when publishing
            a pre-release version (e.g. 'beta' is the label in '2.0.0-beta.0').
            'rc' is assumed if this option is omitted.

       --publish-command <command>
            Specify the command to be run to publish the package. It may refer
            to the VERSION and PREVIOUS_VERSION environment variables. A no-op
            command (':' or 'true') prevents the package from being published
            to a registry. 'npm publish' is assumed if this option is omitted.

    -r --repo <repository>
            Specify the remote repository to which to 'git push'.
            The value must be either a URL or the name of a remote.
            The latter is not recommended: it relies on local state.
            'origin' is assumed if this option is omitted.

    -s --script <path>
            Specify a script to be run after the confirmation prompt.
            It is passed VERSION and PREVIOUS_VERSION as environment
            variables. xyz aborts if the script's exit code is not 0.

    -t --tag <template>
            Specify the format of the tag name. As with --message,
            'X.Y.Z' acts as a placeholder for the version number.
            'vX.Y.Z' is assumed if this option is omitted.

       --dry-run
            Print the commands without evaluating them.

    -v --version
            Print xyz's version number and exit.

## Integration

Installing xyz globally is okay, but it's good practice to add it as a dev
dependency.

### npm

```json
  "scripts": {
    "release": "xyz --repo git@github.com:owner/repo.git --increment",
  }
```

```console
$ npm run release minor
```

### Make

```make
XYZ = node_modules/.bin/xyz --repo git@github.com:owner/repo.git

.PHONY: release-major release-minor release-patch
release-major release-minor release-patch:
	@$(XYZ) --increment $(@:release-%=%)
```

```console
$ make release-minor
```
