# Making Your Own Theme

If you're unhappy with the existing themes, or just want to add your own flair to your notebook, the Notebookinator supports custom themes. We highly recommend you familiarize yourself with the [Typst Documentation](typst.app/docs) before trying to implement one yourself.

Themes consist of two different parts, the theme itself, and its corresponding components.

The theme is just a dictionary containing functions. These functions specify how the entries and cover should look, as well as global rules for the whole document. We'll cover the required structure of this variable in a [later](#the-theme-variable) section.

Components are simply functions stored in a module. These functions contain things like pro/con tables and decision-matrices. Most components are just standalone, but the Notebookinator does supply some utility functions to help with implementing harder components. Implementing components will be covered in [this](#writing-components) section.

## File Structure

The first thing you'll need to do is create a folder for your theme, somewhere in your notebook. As an example, lets create a theme called `foo`. The first thing we'll want to do is create a folder called `foo/`. Then, inside that folder, we'll want to create a file called `foo.typ` inside the `foo/` folder. This will be the entry point for your theme, and will contain your theme variable.

Then, we'll want to create a `foo/components/components.typ` file. This file will contain all of your components. We recommend having each component inside of its own file. For example, an `example-component` might be defined in `foo/components/example-component.typ`.

You'll also want to create an `entries.typ` file to contain all of your entry functions for your theme variable, and a `rules.typ` to store your global rules.

Your final file structure should look like this:

- `foo/`
  - `foo.typ`
  - `entries.typ`
  - `rules.typ`
  - `components/`
    - `components.typ`

```admonish info
This is just the recommended file structure, as long as you expose a theme variable and components, your theme will work just like all the others. You can also add any additional files as you wish.
```

## The Theme Variable

Now that you've created your files, you can begin writing your theme. The first thing you should do is create a theme variable. Going back to our `foo` example, lets create a `foo-theme` variable in our `foo/foo.typ` file.

```typ
// foo/foo.typ

#let foo-theme = (:) // currently a blank dictionary
```

Currently our theme is blank, and will do nothing. If we try to apply it right now, all functions will fall back onto the `default-theme`.

### Creating The Entries

Now that we actually have a place to put our theme functions, we can start implementing our entry functions.

Each of these functions has 2 requirements:

- it must return a `page` function as output
- it must take a dictionary parameter named `ctx` as input, and a parameter called body.

The `ctx` argument provides context about the current entry being created. This dictionary contains the following fields:

- `title`: `str`
- `type`: `str`
- `date`: `datetime`
- `author`: `str`
- `witness`: `str`

`body` contains the content the user has written. It should be passed into the `page` function in some shape or form.

We'll write these functions in the `foo/entries.typ` file. Below are some minimal starting examples:

### Frontmatter

```typ
// foo/entries.typ

#let frontmatter-entry(ctx: (:), body) = {
  show: page.with( // pass the entire function scope into the `page` function
    header: [ = ctx.title ],
    footer: context counter(page).display("i")
  )

  body // display the users's written content
}
```

### Body

```typ
// foo/entries.typ

#let body-entry(ctx: (:), body) = {
  show: page.with(
    header: [ = Body header ],
    footer: counter(page).display("1")
  )

  body
}
```

### Appendix

```typ
// foo/entries.typ

#let appendix-entry(ctx: (:), body) = {
  show: page.with(
    header: [ = Appendix header ],
    footer: counter(page).display("i")
  )

  body
}
```

With the entry functions written, we can now add them to the theme variable.

```typ
// foo/foo.typ

// import the entry functions
#import "./entries.typ": frontmatter-entry, body-entry, appendix-entry

// store the entry functions in the theme variable
#let foo-theme = (
  frontmatter-entry: frontmatter-entry,
  body-entry: body-entry,
  appendix-entry: appendix-entry,
)
```

### Creating a Cover

Then you'll have to implement a cover. The only required parameter here is a
context variable, which stores information like team number, game season and
year.

Here's an example cover:

```typ
// foo/entries.typ

#let cover(ctx: (:)) = [
  #set align(center)
  *Foo Cover*
]
```

Then, we'll update the theme variable accordingly:

```typ
// foo/foo.typ

// import the cover along with the entry functions
#import "./entries.typ": cover frontmatter-entry, body-entry, appendix-entry

#let foo-theme = (
  cover: cover, // store the cover in the theme variable
  frontmatter-entry: frontmatter-entry,
  body-entry: body-entry,
  appendix-entry: appendix-entry,
)
```

### Rules

Next you'll have to define the rules. This function defines all of the global
configuration and styling for your entire theme. This function must take a doc
parameter, and then return that parameter. The entire document will be passed
into this function, and then returned. Here's and example of what this could
look like:

```typ
// foo/rules.typ

#let rules(doc) = {
  set text(fill: red) // Make all of the text red, across the entire document

  doc // Return the entire document
}
```

Then, we'll update the theme variable accordingly:

```typ
// foo/foo.typ
#import "./rules.typ": rules // import the rules
#import "./entries.typ": cover frontmatter-entry, body-entry, appendix-entry

#let foo-theme = (
  rules: rules, // store the rules in the theme variable
  cover: cover,
  frontmatter-entry: frontmatter-entry,
  body-entry: body-entry,
  appendix-entry: appendix-entry,
)
```

## Writing Components

With your base theme done, you may want to create some additional components for you to use while writing your entries. This could be anything, including graphs, tables, Gantt charts, or anything else your heart desires. We recommend including the following components by default:

- Table of contents `toc()`
- Decision matrix: `decision-matrix()`
- Pros and cons table: `pro-con()`
- Glossary: `glossary()`

We recommend creating a file for each of these components. After doing so, your file structure should look like this:

- `foo/components/`
  - `components.typ`
  - `toc.typ`
  - `decision-matrix.typ`
  - `pro-con.typ`
  - `glossary.typ`

Once you make those files, import them all in your `components.typ` file:

```typ
// foo/components.typ

// make sure to glob import every file
#import "./toc.typ": *
#import "./glossary.typ": *
#import "./pro-con.typ": *
#import "./decision-matrix.typ": *
```

Then, import your `components.typ` into your theme's entry point:

```typ
// foo/foo.typ

#import "./components/components.typ" // make sure not to glob import here
```

### Pro / Con Component

### TOC Component

### Decision Matrix Component

### Glossary Component

## Using the Theme

Now that you've written the theme, you can apply it to your notebook.

In the entry point of your notebook (most likely `main.typ`), import your theme like this:

```typ
// main.typ

#import "foo/foo.typ": foo-theme, components
```

Once you do that, change the theme to `foo-theme`:

```
// main.typ

#show: notebook.with(
  theme: foo-theme
)
```
