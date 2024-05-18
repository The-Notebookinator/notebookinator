#import "colors.typ": *

#let frontmatter-entry(ctx: (:), body) = {
  show: page.with(
    header: [ = #ctx.title],
    footer: counter(page).display("i")
  )

  body
}

#let body-entry(ctx: (:), body) = {
  let header-map = (
    "identify" : "IDENTIFY PROBLEM",
    "brainstorm" : "BRAINSTORM SOLUTIONS",
    "select" : "SELECT AND PLAN",
    "build" : "BUILD SOLUTION",
    "test" : "TEST SOLUTION",
    "program" : "PROGRAM SOLUTION",
    "improve" : "IMPROVE SOLUTION"
  )

  show: page.with(
    paper: "us-letter",
    margin: (top: 100pt),
    header: align(center)[
      #text(size:24pt)[#header-map.at(ctx.type)] \
      #grid(
        rows: 10pt,
        columns: (auto, auto, auto),
        column-gutter: 10pt,
        align(horizon)[#line(length: 100%)],
        align(top)[#ctx.title],
        align(horizon)[#line(length: 100%)]
      )
    ],
    footer: context counter(page).display()
  )

  context ( if calc.even(counter(page).get().at(0)) {
    grid( 
      rows: auto,
      columns: (1fr, 19fr),
      column-gutter: 10pt,
      box(fill: color-map.at(ctx.type).transparentize(50%), height: 100%, width: 100%)[
        #align(horizon)[
          #rotate(90deg, origin : center, reflow: true)[
            #header-map.at(ctx.type)#v(40%)
          ]
        ]
      ],
      body
    )
  } else {
    grid(
      rows: auto,
      columns: (19fr, 1fr),
      column-gutter: 10pt,
      body,
      box(fill: color-map.at(ctx.type).transparentize(50%), height: 100%, width: 100%)[
        #align(horizon)[
          #rotate(-90deg, origin : center, reflow: true)[
            #v(40%)#header-map.at(ctx.type)
          ]
        ]
      ]
    )
  })
}

#let appendix-entry(ctx: (:), body) = {
  show: page.with(
    header: [ = #ctx.title],
    footer: counter(page).display("i")
  )

  body
}

#let cover(ctx: (:)) = [
  #set align(center)
  #text(size: 26pt)[ \ \ \ \
    == ENGINEERING NOTEBOOK
    ]

]