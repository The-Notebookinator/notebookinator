#import "/utils.typ"

#let rules(doc) = {
  doc
}

#let cover(context: (:)) = [
  #set align(center)
  *Default Cover*
]

#let toc() = {
  utils.print-toc(context => [
    #context.title
    #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
    #context.page-number
  ])

  utils.print-toc(type: "appendix", context => [
    #context.title
    #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
    #context.page-number
  ])
}

#let frontmatter-entry(context: (:), body) = {
  show: page.with(header: [ = Frontmatter header ], footer: [Frontmatter footer])

  body
}

#let body-entry(context: (:), body) = {
  show: page.with(header: [ = Body header ], footer: [Body footer])

  body
}
#let appendix-entry(context: (:), body) = {
  show: page.with(header: [ = Appendix header ], footer: [Appendix footer])

  body
}

#let default-theme = (
  // Global show rules
  rules: rules, cover: cover,
  // Entry pages
  frontmatter-entry: frontmatter-entry, body-entry: body-entry, appendix-entry: appendix-entry,
)
