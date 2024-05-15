# Contributing a Theme

Before you get started, we ask that you read our [contributing guide](https://github.com/The-Notebookinator/notebookinator/blob/main/.github/CONTRIBUTING.md).

Upon cloning your fork of the Notebookinator, you can find all of the existing themes in the `themes/` folder.

Each theme in the `themes/` folder follows the same file structure detailed in the [previous](./custom_themes.md) guide. If you have a theme on hand, just copy it into the `themes/` folder. For example, the foo theme's entry point should now be at `themes/foo/foo.typ`

If you refer to the Notebookinator as a local package anywhere in your theme, make sure to replace those imports with references to the files directly.

For example, if a file imports `utils` like this:

```typ
#import "@local/notebookinator:1.0.1": utils
```

Replace it with this:

```typ
#import "/utils.typ"
```

If you don't currently have a theme written, follow the [previous](./custom_themes.md) guide from the beginning, but place the theme folder in the `themes/` folder.
