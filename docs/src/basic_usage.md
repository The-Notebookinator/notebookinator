# Basic Usage

Now that you have the Notebookinator installed, you can start notebooking.

## Setup

You can use our [template](https://github.com/The-Notebookinator/quick-start-template) either by creating a GitHub repository based on it with GitHub's official template feature, or just by downloading it. You can download the template simply by cloning it.

```sh
git clone https://github.com/The-Notebookinator/quick-start-template.git
# alternatively if you made your own repository you can clone it like this:
git clone <your-url-here>
```

Once you've done that, open the newly downloaded folder inside of VSCode or your editor of choice.

## Editing Your Notebook

### Adding New Entries

The template puts all of the body entries inside of the `entries/` folder. To make a new entry, make a new file in that folder. Then, `#include` that file in the `entries/entries.typ` file. For example, if you created a file called `entries/my-entry.typ`, then you'd add this line to your `entries/entries.typ` file:

```typ
#include "./my-entry.typ"
```

Body entries will be displayed in the order they are included in the `entries/entries.typ` file.

### Changing the Theme

## Compiling / Viewing Your Notebook

```sh
typst compile main.typ
# or if you want live updates
typst watch main.typ
```
