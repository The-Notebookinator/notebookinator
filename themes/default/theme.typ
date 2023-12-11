#let rules(doc) =  {
  doc
}

#let toc() = {
  outline()
}

#let frontmatter_title(ctx: (:), body) = {
  heading(body)
}

#let frontmatter_footer(ctx: (:), body) = {
  body
}

#let entry_title(ctx: (:), body) = {
  heading(body)
}

#let entry_footer(ctx: (:), body) = {
  body
}

#let appendix_title(ctx: (:), body) = {
  heading(body)
}

#let appendix_footer(ctx: (:), body) = {
  body
}

#let default_theme = (
    rules: rules,
    frontmatter_title: frontmatter_title,
    frontmatter_footer: frontmatter_footer,

    entry_title: entry_title,
    entry_footer: entry_footer,

    appendix_title: appendix_title,
    appendix_footer: appendix_footer,
)
