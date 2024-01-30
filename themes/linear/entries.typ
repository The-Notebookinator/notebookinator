#import "format.typ": *

#let cover(context: (:)) = [
  #set align(center)
  #set text(size: 40pt)
  *Linear Cover*
]

#let frontmatter-entry(context: (:), body) = {
  show: page.with(
    //margin: (top: 8em),
    header: [ 
      #set align(center)
      #set text(size: 20pt)
      
      #context.title
      
    ],
    background: set-margins(8%, 8%),
  )
  body
}

#let body-entry(context: (:), body) = {
  show: page.with(margin: (top: 88pt), header: [ 
    #set align(center)
    #set text(size: 30pt) 
    #box(
      //baseline: 2pt,
      fill: entry-type-metadata.at(context.type),
      width: 300pt,
      inset: 10pt,
      [#context.title],
    )
  ], footer: [
    #set align(left)
    Written by:
    #h(30%)
    Witnessed by:
  ], background: set-margins(8%, 8%))
  
  show heading: it => {
    set-heading(it, context.type)
  }
  
  body
}

#let appendix-entry(context: (:), body) = {
  show: page.with(header: [
    #set align(center)
    #set text(size: 20pt)
    #context.title 

  ], background: set-margins(8%, 8%))
  body
}
