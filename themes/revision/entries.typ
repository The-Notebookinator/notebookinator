#import "colors.typ": *

#let frontmatter-entry(ctx: (:), body) = {
  show: page.with(
    paper: "us-letter",
    margin: (y: 90pt),
    header: align(center)[
      #text(size:24pt)[#upper(ctx.title)] \
      #line(length: 100%)
    ],
    footer: grid(
      rows: (10pt, auto),
      columns: (auto, auto, auto),
      column-gutter: 10pt,
      row-gutter: 10pt,
      align(horizon+right)[#line(length: 100%)],
      align(top)[#context(counter(page).display("I"))],
      align(horizon+left)[#line(length: 100%)],
      align(left)[#text(weight: "bold")[Authors:]],
      [],
      align(right)[#text(weight: "bold")[Date:] #ctx.date.display("[month]/[day]/[year]")]
    )
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
    margin: (y: 90pt),
    header: align(center)[
      #text(size:24pt)[#header-map.at(ctx.type)] \
      #grid(
        rows: 10pt,
        columns: (auto, auto, auto),
        column-gutter: 10pt,
        align(horizon+right)[#line(length: 100%)],
        align(top)[#ctx.title],
        align(horizon+left)[#line(length: 100%)]
      )
    ],
    footer: grid(
      rows: (10pt, auto),
      columns: (auto, auto, auto),
      column-gutter: 10pt,
      row-gutter: 10pt,
      align(horizon+right)[#line(length: 100%)],
      align(top)[#context(counter(page).display())],
      align(horizon+left)[#line(length: 100%)],
      align(left)[#text(weight: "bold")[Authors:]],
      [],
      align(right)[#text(weight: "bold")[Date:] #ctx.date.display("[month]/[day]/[year]")]
    )
  )
  context(if calc.even(here().position().at("page")){
    place(left + top, dx: -35pt, dy: -33.5pt)[
      #box(fill: color-map.at(ctx.type).transparentize(50%), height: 100% + 66pt, width: 5%)[
        #align(horizon)[
          #rotate(90deg, origin : center, reflow: true)[
            #header-map.at(ctx.type)#v(40%)
          ]
        ]
      ]
    ]   
  } else {
    place(right + top, dx: 35pt, dy: -32.5pt)[
      #box(fill: color-map.at(ctx.type).transparentize(50%), height: 100% + 66pt, width: 5%)[
        #align(horizon)[
          #rotate(90deg, origin : center, reflow: true)[
            #v(40%)#header-map.at(ctx.type)
          ]
        ]
      ]
    ]
  })
  body
}

#let appendix-entry(ctx: (:), body) = {
  show: page.with(
    paper: "us-letter",
    margin: (y: 90pt),
    header: align(center)[
      #text(size:24pt)[#upper(ctx.title)] \
      #line(length: 100%)
    ],
    footer: grid(
      rows: (10pt, auto),
      columns: (auto, auto, auto),
      column-gutter: 10pt,
      row-gutter: 10pt,
      align(horizon+right)[#line(length: 100%)],
      align(top)[#context(counter(page).display("I"))],
      align(horizon+left)[#line(length: 100%)],
      align(left)[#text(weight: "bold")[Authors:]],
      [],
      align(right)[#text(weight: "bold")[Date:] #ctx.date.display("[month]/[day]/[year]")]
    )
  )
  body
}

#let cover(ctx: (:)) = [
  #set align(center)
  #text(size: 26pt)[ \ \ \ \
    == ENGINEERING NOTEBOOK
  ]
]