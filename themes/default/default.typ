#let rules(doc) = {
  doc
}

#let toc() = {
  outline()
}

#let frontmatter_entry(context: (:), body) = {
  show: page.with(
    header: [ = Frontmatter header],
    footer: [Frontmatter footer],
  )

  body
}

#let body_entry(context: (:), body) = {
  show: page.with(
    header: [ = Body header],
    footer: [Body footer],
  )

  body
}
#let appendix_entry(context: (:), body) = {
  show: page.with(
    header: [ = Appendix header],
    footer: [Appendix footer],
  )

  body
}

#let default_theme = (
  // Global show rules
  rules: rules,
  
  // Entry pages
  frontmatter_entry: frontmatter_entry,
  body_entry: body_entry,
  appendix_entry: appendix_entry,
)
