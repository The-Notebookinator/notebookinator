#import "/utils.typ"

#let rules(doc) = {
  doc
}

#let cover(context: (:)) = [
  #set align(center)
  *Default Cover*
]

#let toc() = utils.print-toc((_, body, appendix) => {
  for entry in body [
    #entry.title
    #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
    #entry.page-number
  ]

  for entry in appendix [
    #entry.title
    #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
    #entry.page-number
  ]
})

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
  rules: rules,
  cover: cover,
  // Entry pages
  frontmatter-entry: frontmatter-entry,
  body-entry: body-entry,
  appendix-entry: appendix-entry,
)
