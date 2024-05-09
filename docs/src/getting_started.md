# Installation

#info[
This installation process is temporary, as we wait for Typst to overhaul its
process for packaging templates and packages.
]

The best way to install the Notebookinator is as a local package. Make sure you
have the following software installed on your computer:

- [Typst](https://github.com/casey/just#installation)
- [Git](https://github.com/casey/just#installation)
- [VSCode](https://code.visualstudio.com/)
- [just](https://github.com/casey/just#installation)

Once you've installed everything, simply run the following commands:

```bash
git clone https://github.com/BattleCh1cken/notebookinator
cd notebookinator
just install
```

> If you're running this on Windows, you'll need to run these commands in a sh
> shell, like git-bash or the shell packaged with Cygwin or GitHub Desktop.

# Basic Usage

Once the template is installed, you can import it into your project like this:

```typ
#import "@local/notebookinator:1.0.1": *
```

Once you've done that you can begin to write your notebook:

```typ
#import themes.default: default-theme, components

#show: notebook.with(theme: default-theme)

#create-body-entry(title: "My Entry")[
 #lorem(200)
]
```

You can then compile your notebook with the Typst CLI:

```bash
typst compile your-notebook-file.typ
```
