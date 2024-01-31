#import "format.typ": *
#import "./colors.typ": *

#let cover(context: (:)) = {
  place(horizon + left, dx: -71pt, float: false)[
    #line(length: 135%, stroke: 2pt)
    #h(5pt)
    #rect(inset: 30pt, fill: surface-0, width: 135%)[
      #grid(columns: (1fr, 1fr), [
        #set text(72pt)
        #context.team-name
        #set text(20pt)
         
        #context.season
         
        Engineering Design Notebook
      ])
       
    ]
    #line(length: 135%, stroke: 2pt)
  ]
}


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
