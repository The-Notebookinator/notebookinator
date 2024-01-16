#import "format.typ": *

#let cover(context: (:)) = [
  #set align(center)
  #set text(size: 40pt)
  *Linear Cover*
]

#let frontmatter_entry(context: (:), body) = {
  show: page.with(
    header: [ 
      #set align(center)
      #set text(size: 20pt)
      = #context.title 
      ],
    background: set-margins(8%, 8%)
    )
  body
}

#let body_entry(context: (:), body) = {
  show: page.with(
    header: [ 
      #set align(center)
      #set text(size: 20pt) 
      = #context.title 
      ], 
    footer: [
      #set align(left)
      Written by:
      #h(30%)
      Witnessed by:
    ],
    background: set-margins(8%, 8%) 
    )
  show heading: it => {
    set-heading(it, context.type)
  }
  body
}

#let appendix_entry(context: (:), body) = {
  show: page.with(
    header: [
      #set align(center)
      #set text(size: 20pt)
      = #context.title 
      ], 
    background: set-margins(8%, 8%)
    )
  body
}