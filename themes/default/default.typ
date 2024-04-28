#import "./components.typ"

#let rules(doc) = {
  doc
}

#let cover(ctx: (:)) = [
  #set align(center)
  *Default Cover*
]

#let frontmatter-entry(ctx: (:), body) = {
  show: page.with(
    header: [ = #ctx.title
      #box(width: 1fr, line(length: 100%)) ],
    footer: align(center, counter(page).display()),
  )

  body
}

#let body-entry(ctx: (:), body) = {
  show: page.with(
    header: [ = #ctx.title
      #box(width: 1fr, line(length: 100%)) ],
    footer: align(center, counter(page).display()),
  )

  body
}
#let appendix-entry(ctx: (:), body) = {
  show: page.with(
    header: [ = #ctx.title
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
