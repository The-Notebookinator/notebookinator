#import "./components.typ"

#let rules(doc) = {
  doc
}

#let cover(context: (:)) = [
  #set align(center)
  *Default Cover*
]

#let frontmatter-entry(context: (:), body) = {
  show: page.with(
    header: [ = #context.title
      #box(width: 1fr, line(length: 100%)) ],
    footer: align(center, counter(page).display()),
  )

  body
}

#let body-entry(context: (:), body) = {
  show: page.with(
    header: [ = #context.title
      #box(width: 1fr, line(length: 100%)) ],
    footer: align(center, counter(page).display()),
  )

  body
}
#let appendix-entry(context: (:), body) = {
  show: page.with(
    header: [ = #context.title
      #box(width: 1fr, line(length: 100%)) ],
    footer: align(center, counter(page).display()),
  )

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
