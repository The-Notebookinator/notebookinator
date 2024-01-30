#import "./packages.typ": codly, tidy

#let docs-template(
  title: "", subtitle: "", abstract: [], authors: (), url: none, date: none, version: none, body,
) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center)
  set text(font: "Linux Libertine", lang: "en")

  show heading.where(level: 1): it => block(smallcaps(it), below: 1em)
  set heading(numbering: "1.")

  // show link: set text(fill: purple.darken(30%))
  show link: set text(fill: rgb("#1e8f6f"))
  show link: underline

  v(4em)

  // Title row.
  align(center)[
    #block(text(weight: 700, 1.75em, title))
    #block(text(1.0em, subtitle))
    #v(4em, weak: true)
    v#version #h(1.2cm) #date
    #block(link(url))
    #v(1.5em, weak: true)
  ]

  // Author information.
  pad(
    top: 0.5em, x: 2em, grid(
      columns: (1fr,) * calc.min(3, authors.len()), gutter: 1em, ..authors.map(author => align(center, strong(author))),
    ),
  )

  v(3cm, weak: true)

  // Abstract.
  pad(
    x: 3.8em, top: 1em, bottom: 1.1em, align(
      center,
    )[
      #heading(outlined: false, numbering: none, text(0.85em, smallcaps[Abstract]))
      #abstract
    ],
  )

  // Main body.
  set par(justify: true)
  v(10em)

  show: codly-init
  codly()
  show raw.where(block: true): set text(size: .95em)
  show raw.where(block: true): it => pad(x: 4%, it)

  show raw.where(block: false): it => if it.text.starts-with("<") and it.text.ends-with(">") {
    set text(1.2em)
    tidy.styles.default.show-type(it.text.slice(1, -1))
  } else {
    it
  }

  pagebreak()

  body
}

#let show-module-fn(module, fn, ..args) = {
  module.functions = module.functions.filter(f => f.name == fn)
  tidy.show-module(
    module, ..args.pos(), ..args.named(), show-module-name: false, show-outline: false,
  )
}

#let show-module = tidy.show-module.with(show-outline: false, sort-functions: none, first-heading-level: 2)

#let def-arg(term, t, default: none, description) = {
  if type(t) == str {
    t = t.replace("?", "|none")
    t = `<` + t.split("|").map(s => {
      if s == "b" {
        `boolean`
      } else if s == "s" {
        `string`
      } else if s == "i" {
        `integer`
      } else if s == "f" {
        `float`
      } else if s == "c" {
        `coordinate`
      } else if s == "d" {
        `dictionary`
      } else if s == "a" {
        `array`
      } else if s == "n" {
        `number`
      } else {
        raw(s)
      }
    }).join(`|`) + `>`
  }

  stack(
    dir: ltr, [/ #term: #t \ #description], align(right, if default != none { [(default: #default)] }),
  )
}
