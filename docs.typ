#import "@preview/tidy:0.1.0"

#let show-module = tidy.show-module.with(show-outline: false, sort-functions: none)

#let show-module-fn(module, fn, ..args) = {
  module.functions = module.functions.filter(f => f.name == fn)
  tidy.show-module(
    module, ..args.pos(), ..args.named(), show-module-name: false, show-outline: false,
  )
}

#set heading(numbering: "1.")
#set terms(indent: 1em)
#show link: set text(blue)

#set page(numbering: "1/1", header: align(right)[The Notebookinator])

#align(center, text(16pt)[*The Notebookinator*])

#set par(justify: true)

#outline(indent: true, depth: 3)
#pagebreak(weak: true)

= Introduction

Welcome to the Notebookinator, a Typst package meant to simply the notebooking
process for the Vex Robotics Competition. Its theming capabilities handle all of
the styling for you, letting you jump right into writing documentation.

While it was designed with VRC in mind, it could just as easily be used for
other competitor systems such as the First Robotics Competition and the First
Tech Challenge.

= Installation

The best way to install the Notebookinator is as a local package. Make sure you
have the following software installed on your computer:

- Typst
- Git
- VSCode

Once you have those, find the matching command for you operating system, and
then run it:

// TODO: find correct link
```sh
# Linux
git glone https://github.com/BattleCh1cken/notebookinator ~/.local/share/typst/packages/local/

# MacOS
git glone https://github.com/BattleCh1cken/notebookinator ~/Library/Application Support/typst/packages/local/

```

```ps
# Windows
git glone https://github.com/BattleCh1cken/notebookinator %APPDATA%\typst\packages\local\
```
= Basic Usage

Once the template is installed, you can import it into your project like this:

```typ
#import "@local/notebookinator": *
```
Once you've done that you can begin to write your notebook:
```typ
#import themes.radial: radial_theme, components

#show: notebook.with(theme: radial_theme)

#create_frontmatter_entry(title: "Table of Contents")[
  #components.toc()
]
```
= API Reference

#let template_module = tidy.parse-module(read("lib.typ"), name: "Template")
#show-module(template_module)

#let entries_module = tidy.parse-module(read("entries.typ"), name: "Entries")
#show-module(entries_module)

#let glossary_module = tidy.parse-module(read("glossary.typ"), name: "Glossary")
#show-module(glossary_module)

== Radial Theme

#let radial-module = tidy.parse-module(read("./themes/radial/radial.typ"), name: "Template")
#show-module(radial-module)

= Developer Documentation

== Project Architecture

The Notebookinator is split into two sections, the base template, and the
themes. The base template functions as the backend of the project. It handles
all of the information processing, keeps track of global state, makes sure page
numbers are correct, and so on. It exposes the main API that the user interacts
for creating entries and creating glossary entries.

The themes act as the frontend to the project, and are what the user actually
sees. The themes expose an API for components that need to be called directly
inside of entries. This could include things like admonitions, charts, and
decision matrices.

== File Structure

- `lib.typ`: The entrypoint for the whole template.
- `entries.typ`: Contains the user facing API for entries, as well as the internal
  template functions for printing out the entries and cover.
- `glossary.typ`: Contains the user facing API for the glossary.
- `globals.typ`: Contains all of the global variables for the entire project.
- `utils.typ`: Utility functions intended to help implement themes.
- `themes/`: The folder containing all of the themes.
  - `themes.typ`: An index of all the themes are contained in the template
- `docs.typ`: The entry point for the project documentation.
- `docs-template.typ`: The template for the project documentation.

== Implementing Your Own Theme

The following section covers how to add a theme to the ones already in the
template. It only covers how to write the code, and not how to get it merged
into the main project. If you want to learn more about our contributing
guidelines, check our `CONTRIBUTING.MD` file in our GitHub.

=== Creating the Entry Point

This section of the document covers how to add your own theme to the template.
The first thing you'll have to do is create the entry point for your theme.
Create a new directory inside the `themes/` directory, then create a Typst
source file inside of that directory. For example, if you had a theme called `foo`,
the path to your entry point would look like this: `themes/foo/foo.typ`.

Once you do this, you'll have to add your theme to the `themes/themes.typ` file
like this:

```typ
#import `./foo/foo.typ`
```
Do not use a glob import, we don't want to pollute the namespace with the
functions in the theme.

=== Implementing Theme Functions

Next you'll have to implement the functions contained inside the theme. These
functions are all called internally by the template. While we recommend that you
create implementations for all of them, if you omit one the template will fall
back on the default theme.

The first functions you should implement are the ones that render the entries.
You'll need three of these, one for each type of entry (frontmatter, body, and
appendix).

Each of these functions must take a context parameter, and a body parameter. The
context parameter provides important information, like the type of entry, and
the date it was written at. The body parameter contains the content written by
the user.

// TODO: document the context data type

The template expects that each of these functions returns a `#page()` as
content.

Here's a minimal example of what these functions might look like:

```typ
#let frontmatter_entry(context: (:), body) = {
  show: page.with(
    header: [ = Frontmatter header ],
    footer: counter(page).display("i")
  )

  body
}
```

```typ
#let body_entry(context: (:), body) = {
  show: page.with(
    header: [ = Body header ],
    footer: counter(page).display("1")
  )

  body
}
```

```typ
#let appendix_entry(context: (:), body) = {
  show: page.with(
    header: [ = Appendix header ],
    footer: counter(page).display("i")
  )

  body
}
```

Next you'll have to define the rules. This function defines all of the global
configuration and styling for your entire theme. This function must take a doc
parameter, and then return that parameter. The entire document will be passed
into this function, and then returned. Here's and example of what this could
look like:

```typ
#let rules(doc) = {
  set text(fill: red) // Make all of the text red

  doc // Return the entire document
}
```

Then you'll have to implement a cover. The only required parameter here is a
context variable, which stores information like team number, game season and
year.

Here's an example cover:

```typ
#let cover(context: (:)) = [
  #set align(center)
  *Foo Cover*
]
```

=== Defining the Theme

// TODO: create a theme type documentation thingy

Once you define all of your functions you'll have to actually define your theme.
The theme is just a dictionary which stores all of the functions that you just
defined.

The theme should be defined in your theme's entry point (`themes/foo/foo.typ` for
this example).

Here's what the theme would look like in this scenario:

```typ
#let foo_theme = (
  // Global show and set rules
  rules: rules,

  cover: cover,

  // Entry pages
  frontmatter_entry: frontmatter_entry,
  body_entry: body_entry,
  appendix_entry: appendix_entry
)
```
=== Creating Components

With your base theme done, you may want to create some additional components for
you to use while writing your entries. This could be anything, including graphs,
tables, Gantt charts, or anything else your heart desires.

// TODO: define a standard set of components that themes should implement.

#let utils-module = tidy.parse-module(read("utils.typ"), name: "Utility Functions")
#tidy.show-module(utils-module, show-outline: false)
