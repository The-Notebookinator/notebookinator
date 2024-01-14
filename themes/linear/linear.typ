#import "/utils.typ"

#let rules(doc) = {
  doc
}

#let cover(context: (:)) = [
  #set align(center)
  *Linear Cover*
]

#let border(x, y) = {
  set line(stroke: 1.5pt)
  let borderTL = 0% + 15%
  let borderTR = 100% - 15%
  place(
    // Left border line
    line(start: (0% + x, 5%), end: (0% + x, 100% - y))
  )
  place(
    // Right border line
    line(start: (100% - x, 5%), end: (100% - x, 100% - y))
  )
  place(
    // Bottom border line
    line(start: (0% + x, 100% - y), end: (100% - x, 100% - y))
  )
  place(
    // Top left border line -> ——
    line(start: (0% + x, 5%), end: (borderTL + x, 5%))
  )
  place(
    // Top right border line -> ——
    line(start: (100% - x, 5%), end: (borderTR - x, 5%))
  )
  place(
    // Top left border line -> ︱
    line(start: (borderTL + x, 4%), end: (borderTL + x, 6%))
  )
  place(
    // Top left border line -> ︱
    line(start: (borderTR - x, 4%), end: (borderTR - x, 6%))
  )
}

#let heading(context: (:)) = {
  box(inset: 0.5em, fill: red)[context]
  h(5pt)
  box(baseline: -10pt, width: 1fr, line(length: 100%))
}

#let toc() = {
  utils.print_toc(context => [
    #context.title
    #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
    #context.page_number
  ])

  utils.print_toc(type: "appendix", context => [
    #context.title
    #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
    #context.page_number
  ])
}

#let frontmatter_entry(context: (:), body) = {
  show: page.with(
    header: [ 
      #set align(center)
      = Frontmatter header 
      ],
    footer: [ Frontmatter footer ],
    background: border(8%, 8%)
    )
  body
}

#let body_entry(context: (:), body) = {
  show: page.with(
    header: [ 
      #set align(center) 
      = Body header 
      ], 
    footer: [ Body footer ],
    background: border(8%, 8%) 
    )
  body
}
#let appendix_entry(context: (:), body) = {
  show: page.with(header: [
    #set align(center)
    = Appendix header 
    ], 
    footer: [ Appendix footer ],
    background: border(8%, 8%)
    )
  body
}

#let linear_theme = (
  // Global show rules
  rules: rules, cover: cover,
  // Entry pages
  frontmatter_entry: frontmatter_entry, body_entry: body_entry, appendix_entry: appendix_entry,
)