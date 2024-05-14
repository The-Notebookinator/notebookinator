# Developer Documentation

## Project Architecture

The Notebookinator is split into two sections, the base template, and the
themes. The base template functions as the backend of the project. It handles
all of the information processing, keeps track of global state, makes sure page
numbers are correct, and so on. It exposes the main API that the user interacts
for creating entries and creating glossary entries.

The themes act as the frontend to the project, and are what the user actually
sees. The themes expose an API for components that need to be called directly
inside of entries. This could include things like admonitions, charts, and
decision matrices.

## File Structure

- `lib.typ`: The entrypoint for the whole template.
- `internals.typ`: All of the internal function calls that should not be used by
  theme authors or users.
- `entries.typ`: Contains the user facing API for entries, as well as the internal
  template functions for printing out the entries and cover.
- `glossary.typ`: Contains the user facing API for the glossary.
- `globals.typ`: Contains all of the global variables for the entire project.
- `utils.typ`: Utility functions intended to help implement themes.
- `themes/`: The folder containing all of the themes.
  - `themes.typ`: An index of all the themes are contained in the template
- `docs.typ`: The entry point for the project documentation.
- `docs-template.typ`: The template for the project documentation.

## Implementing Your Own Theme

The following section covers how to add a theme to the ones already in the
template. It only covers how to write the code, and not how to get it merged
into the main project. If you want to learn more about our contributing
guidelines, check our `CONTRIBUTING.MD` file in our GitHub.

### Creating the Entry Point

This section of the document covers how to add your own theme to the template.
The first thing you'll have to do is create the entry point for your theme.
Create a new directory inside the `themes/` directory, then create a Typst
source file inside of that directory. For example, if you had a theme called
`foo`, the path to your entry point would look like this: `themes/foo/foo.typ`.

Once you do this, you'll have to add your theme to the `themes/themes.typ` file
like this:

```typ
#import `./foo/foo.typ`
```

Do not use a glob import, we don't want to pollute the namespace with the
functions in the theme.

### Implementing Theme Functions

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

<!-- TODO: document the context data type-->

The template expects that each of these functions returns a `#page()` as
content.

Here's a minimal example of what these functions might look like:

```typ
#let frontmatter-entry(ctx: (:), body) = {
  show: page.with(
    header: [ = Frontmatter header ],
    footer: counter(page).display("i")
  )

  body
}
```

```typ
#let body-entry(ctx: (:), body) = {
  show: page.with(
    header: [ = Body header ],
    footer: counter(page).display("1")
  )

  body
}
```

```typ
#let appendix-entry(ctx: (:), body) = {
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
#let cover(ctx: (:)) = [
  #set align(center)
  *Foo Cover*
]
```

### Defining the Theme

<!-- TODO: create a theme type documentation thingy -->

Once you define all of your functions you'll have to actually define your theme.
The theme is just a dictionary which stores all of the functions that you just
defined.

The theme should be defined in your theme's entry point (`themes/foo/foo.typ`
for this example).

Here's what the theme would look like in this scenario:

```typ
#let foo-theme = (
  // Global show and set rules
  rules: rules,

  cover: cover,

  // Entry pages
  frontmatter-entry: frontmatter-entry,
  body-entry: body-entry,
  appendix-entry: appendix-entry
)
```

### Preparing Your Components

With your base theme done, you may want to create some additional components for
you to use while writing your entries. This could be anything, including graphs,
tables, Gantt charts, or anything else your heart desires. To create a standard 
theme, we recommend the following components:

- Table of contents `toc()`
- Decision matrix: `decision-matrix()`
- Pros and cons table: `pro-con()`
- Glossary: `glossary()`

First, you need to create a namespace to store all of your components like so:

`themes/foo/components/`

We recommend creating a `components.typ` file so you can glob import each component, 
especially if you plan to implement a lot:

`components/components.typ`

Inside the components directory, create your three basic component files (the table of 
contents, decision matrix, pros and cons table, and glossary). Then, glob import each 
file in the `components.typ` file.

```typ
#import "toc.typ": *
#import "decision-matrix.typ": *
#import "pro-con.typ": *
#import "glossary.typ": *
```

To render each component, you need to define a function inside the designated component
file. Note that, if these functions are left blank, the Notebookinator will render the 
Default Theme component if applicable.

The following is an example for the table of contents component:

```typ
#let toc() = {
  // You will customize the table of contents here later.
}
```

Finally, import the `components.typ` file where you defined your theme function (in this
case, `themes/foo/foo.typ`).

```typ
#import "components/components.typ": *

#let foo-theme = (
  ...
)
```

### Creating Components



## Implementing a Private Theme

This section will explain how to create your own theme locally, without adding it
to the Notebookinator. This process is similar to that of the 
[Implementing Your Own Theme](#implementing-your-own-theme) section