#import "@preview/codly:0.1.0": *

#let docs-template(
  title: "",
  subtitle: "",
  abstract: [],
  authors: (),
  url: none,
  date: none,
  version: none,
  body,
  ) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center)
  set text(font: "Linux Libertine", lang: "en")
  
  show heading.where(level: 1): it => block(smallcaps(it), below: 1em)
  set heading(numbering: (..args) => if args.pos().len() == 1 { numbering("I", ..args) })

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
    top: 0.5em,
    x: 2em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(center, strong(author))),
    ),
  )

  v(3cm, weak: true)
  
  // Abstract.
  pad(
    x: 3.8em,
    top: 1em,
    bottom: 1.1em,
    align(center)[
      #heading(
        outlined: false,
        numbering: none,
        text(0.85em, smallcaps[Abstract]),
      )
      #abstract
    ],
  )

  // Main body.
  set par(justify: true)
  v(10em)

  
  show: codly-init
  codly(
    width-numbers: none,
    languages: (
      tyap: (name: "typ", icon: none, color: rgb("#239DAE")),
    ),
  )
  show raw.where(block: true): set text(size: .95em)
  show raw.where(block: true): it => pad(x: 4%, it)

  body
}

#let show-module-fn(module, fn, ..args) = {
  module.functions = module.functions.filter(f => f.name == fn)
  tidy.show-module(
    module, ..args.pos(), ..args.named(), show-module-name: false, show-outline: false,
  )
}
