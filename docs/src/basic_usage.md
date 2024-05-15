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

The Notebookinator allows for three different types of entries, frontmatter, body, and appendix. Each will be rendered as its own section, and has its own page count.

#### Frontmatter

Frontmatter entries, as their name implies, are shown at the beginning of the notebook. Entries of this type typically contain things like introductions, and the table of contents.

The template stores all of the frontmatter entries into the `frontmatter.typ` file by default. To add more frontmatter entries, simply call the `create-frontmatter-entry` function inside of the file like so:

```typ
#create-frontmatter-entry(title: "About")[
    Here's some info about this amazing notebook!
]
```

Frontmatter entries are rendered in the order they are created.

#### Body

The most common type of entry is the body entry. These entries store all of your notebook's main content.

The template puts all of the body entries inside of the `entries/` folder. To make a new entry, make a new file in that folder. Then, `#include` that file in the `entries/entries.typ` file. For example, if you created a file called `entries/my-entry.typ`, then you'd add this line to your `entries/entries.typ` file:

```typ
#include "./my-entry.typ"
```

Body entries will be displayed in the order they are included in the `entries/entries.typ` file.

Once you've done that, you'll need to create a new entry inside of that file. This can be done with the `create-body-entry` function. If the file only contains a single entry, we recommend using a show rule to wrap the function as well, which will pass all of the `content` in the file into the `create-body-entry` function.

You can create a new body entry like so:

```typ
// not all themes require every one of these options
#show: create-body-entry.with(
  title: "My Awesome Entry",
  type: "identify", // The type of the entry depends on which theme you're using
  date: datetime(year: 2024, month: 1, day: 1),
)
```

#### Appendix

Appendix entries go at the end of the notebook, and are stored in the `appendix.typ` file.

You can create a new appendix entry like this:

```typ
#create-appendix-entry(title: "Programming")[
    Here's information about how we programmed the robot.

    #lorem(500)
]
```

### Changing the Theme

In order to change the theme you'll need to edit two files, `packages.typ` and `main.typ`.

The first thing you'll need to do is edit which theme is being imported in `packages.typ`. For example, if you wanted to switch to the `linear` theme from the `radial` theme, you'd change `packages.typ` to look like this:

```typ
// packages.typ

// this file allows us to only specify package versions once
#import "@local/notebookinator:1.0.1": *
#import themes.linear: linear-theme, components // components is imported here so we don't have to specify which theme's components we're using.
```

Once you do that, you'll want to edit your `main.typ` to use the `linear-theme` instead of the `radial-theme`.

```typ
// main.typ

#show: notebook.with(
  // ...
  theme: linear-theme,
)
```

```admonish note
Not all themes implement the same components, so you may encounter some issues when changing themes with a more developed notebook.
```

### Using Components

Components are reusable elements created by themes. These are just functions stored inside a `components` module. Each theme should expose its own separate `components` module.

`packages.typ` should already export this module, so you can access it just by `import`ing `packages.typ`

```typ
#import "/packages.typ": *
```

Now you can use any of the components in the theme by just calling them like you would a normal function. Here's how you would create a simple `pro-con` table.

```typ
#components.pro-con(
    pros: [
    Here are the pros.
    ],
    cons: [
    Here are the cons.
    ]
)
```

You can see what components a theme implements by reading the [API reference](./reference.md).

## Compiling / Viewing Your Notebook

Once you're happy with your notebook, you'll want to render it into a PDF.

You can do that with either of the following commands:

```sh
typst compile main.typ
# or if you want live updates
typst watch main.typ
```

You can then open `main.pdf` in any PDF viewer to see your rendered output.
