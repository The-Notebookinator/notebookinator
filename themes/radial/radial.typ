#let rules(doc) = {
  doc
}

#let frontmatter_title(ctx: (:), body) = {
  heading(body)
}

#let radial_theme = (rules: rules, frontmatter_title: frontmatter_title)
