// ------------- Template -------------------------

#import "@preview/tidy:0.2.0"
#import "@preview/gentle-clues:0.6.0": *

#set heading(numbering: "1.")

#let show-module = tidy.show-module.with(
  show-outline: false,
  sort-functions: none,
  first-heading-level: 2,
)

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
    dir: ltr,
    [/ #term: #t \ #description],
    align(
      right,
      if default != none {
        [(default: #default)]
      },
    ),
  )
}

// ------------------ Document content -------------------------

= Outline

#outline(title: none, indent: true, depth: 3)

= API Reference

== Template

#let template-module = tidy.parse-module(read("../../lib.typ"))
#show-module(template-module)

== Entries

#let entries-module = tidy.parse-module(read("../../entries.typ"))
#show-module(entries-module)

== Glossary

#let glossary-module = tidy.parse-module(read("../../glossary.typ"))
#show-module(glossary-module)

== Additional Datatypes

=== Theme <theme>

Themes are stored as dictionaries with the following fields:

#def-arg(
  "rules",
  [`<function>`],
  default: none,
  [ The show and set rules that will be applied to the document ],
)
#def-arg(
  "cover",
  [`<function>`],
  default: none,
  [ A function that returns the cover of the notebook. Must take ctx as input. ],
)
#def-arg(
  "frontmatter-entry",
  [`<function>`],
  default: none,
  [ A function that returns a frontmatter entry. Must take ctx and body as input. ],
)
#def-arg(
  "body-entry",
  [`<function>`],
  default: none,
  [ A function that returns a body entry. Must take ctx and body as input. ],
)
#def-arg(
  "appendix-entry",
  [`<function>`],
  default: none,
  [ A function that returns a appendix entry. Must take ctx and body as input. ],
)

=== Context <ctx>

Provides information to a callback about how it's being called.

Context is stored as a dictionary with the following fields:

#def-arg("title", [`<string>`], default: none, [The title of the entry])
#def-arg(
  "type",
  [`<string>` or `<none>`],
  default: none,
  [The type of the entry. This value is used differently by different templates.
    Refer to the template level documentation to see what this means for your theme.],
)
#def-arg(
  "date",
  [`<datetime>`],
  default: none,
  [The date at which the entry started.],
)
#def-arg(
  "page-number",
  [`<integer>` or `<none>`],
  default: none,
  [The page number of the first page of the entry. Only available while using the
    `print-toc()` utility function. ],
)

== Default Theme

The default theme contains all the basic components for an engineering notebook,
including a pros and cons table and a decision matrix template.

#warning[
  This theme is very minimal, and is generally intended as a fallback for stuff
  that other themes don't implement.
]

=== Components

#let default-components-module = tidy.parse-module(
  read("../../themes/default/components.typ"),
)
#show-module(default-components-module, first-heading-level: 3)

== Radial Theme

The Radial theme is a minimal theme focusing on nice, rounded corners.

You can change the look of body entries by changing their type. The following
types are available:

- `"identify"`: For entries about the identify stage of the engineering design
  process.
- `"brainstorm"`: For entries about the brainstorm stage of the engineering design
  process.
- `"decide"`: For entries about the decide stage of the engineering design
  process.
- `"build"`: For entries about the build stage of the engineering design process.
- `"program"`: For entries about the programming stage of the engineering design
  process.
- `"test"`: For entries about the testing stage of the engineering design process.
- `"management"`: For entries about team management
- `"notebook"`: For entries about the notebook itself

Minimal starting point:

```typ
// Import the template and theme here

#show: notebook.with(theme: radial-theme)

#create-frontmatter-entry(title: "Table of Contents")[
  #components.toc()
]

#create-body-entry(
  title: "Sample Entry", type: "identify", start-date: datetime(year: 1984, month: 1, day: 1),
)[

= Top Level heading

#lorem(20)

#components.admonition(type: "note")[
  #lorem(20)
]

#components.pro-con(pros: [
  #lorem(50)
], cons: [
  #lorem(20)
])

#components.decision-matrix(
  properties: ("Flavor", "Versatility", "Crunchiness"), ("Sweet Potato", 5, 3, 1), ("White Potato", 1, 2, 3), ("Purple Potato", 2, 2, 2),
)
]

#create-appendix-entry(title: "Glossary")[
  #components.glossary()
]

```

#let parse-modules(predicate, ..names) = {
  for name in names.pos() {
    read(predicate + name + ".typ")
  }
}

=== Components

#let raw-radial-module = parse-modules(
  "../../themes/radial/components/",
  "toc",
  "glossary",
  "admonitions",
  "pro-con",
  "decision-matrix",
  "tournament",
  "graphs",
  "gantt-chart",
  "team",
  "label",
)

#let radial-module = tidy.parse-module(raw-radial-module)
#show-module(first-heading-level: 3, radial-module)

== Linear Theme

The Linear theme is a template that uses straight lines and boxes.

You can change the look of body entries by changing their type. The following
types are available:

- `"identify"`: For entries about the identify stage of the engineering design
  process.
- `"brainstorm"`: For entries about the brainstorm stage of the engineering design
  process.
- `"decide"`: For entries about the decide stage of the engineering design
  process/
- `"build"`: For entries about the build stage of the engineering design process.
- `"program"`: For entries about the programming stage of the engineering design
  process.
- `"test"`: For entries about the testing stage of the engineering design process

*Minimal Starting Point*

```typ
#create-frontmatter-entry(title: "Table of Contents")[
  #components.toc()
]

#create-body-entry(title: "Day 1", type: "identify", date: datetime(year: 1984, month: 1, day: 1))[
  = Heading

  #lorem(50)

  #components.pro-con(
    pros: [
      #list(
        [Sweet potato],
        [Red potato],
        [Yellow potato]
      )
    ],
    cons: [
      #list(
        [Fries],
        [Wedges],
        [Mashed]
      )
    ]
  )
]

#create-body-entry(title: "Day 2", type: "identify", date: datetime(year: 1984, month: 1, day: 2))[
  = Another Heading

  #lorem(50)

  #components.decision-matrix(
    properties: (
      (name: "Lorem", weight: 2),
      (name: "Ipsum")
    ),
    ("Dolor", 1, 3),
    ("Sit", 2, 2),
    ("Amet", 3, 1)
  )

  == A Smaller Heading

  #lorem(50)
]

#glossary.add-term("Term 1")[
  #lorem(10)
]

#glossary.add-term("Term 2")[
  #lorem(10)
]

#create-appendix-entry(title: "Glossary")[
  #components.glossary()
]
```

=== Components

#let raw-linear-module = parse-modules(
  "../../themes/linear/components/",
  "decision-matrix",
  "pro-con",
  "glossary",
  "toc",
)

#let linear-module = tidy.parse-module(raw-linear-module)
#show-module(first-heading-level: 3, linear-module)
