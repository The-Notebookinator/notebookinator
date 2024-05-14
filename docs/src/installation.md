# Installation

```admonish warning
This installation process is temporary, as we wait for Typst to overhaul its
process for packaging templates and packages.
```

## Devcontainer / Codespaces

The easiest way to use the Notebookinator is to use our devcontainer/codespace. This will automatically install all of the needed dependencies inside of a Docker container. We recommend using our [quick start template](https://github.com/The-Notebookinator/quick-start-template) for the best experience.

```admonish warning
While this aproach is easier, you may encounter some performance issues as your notebook increases in size.
```

The only thing you'll need in preparation is a [GitHub](https://github.com/) account (only if using Codespaces) and [VSCode](https://code.visualstudio.com/) installed. Once you do that, just follow the instructions in the [README](https://github.com/The-Notebookinator/quick-start-template).

## Local Installation

This installation process is a little harder, and requires more software to be manually installed on your computer.

Make sure you have the following software installed:

- [Typst](https://github.com/casey/just#installation)
- [Git](https://github.com/casey/just#installation)
- [VSCode](https://code.visualstudio.com/)
- [just](https://github.com/casey/just#installation)

Once you've installed everything, run the following commands:

```admonish info
If you're running this on Windows, you'll need to run these commands in a sh
shell, like git-bash or the shell packaged with Cygwin or GitHub Desktop.
```

```bash
git clone https://github.com/BattleCh1cken/notebookinator
cd notebookinator
just install
cd ..
rm -rf notebookinator
```

Once you do that you should be good to go!
