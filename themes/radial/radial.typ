#import "/utils.typ": print_toc

#let toc() = {
  let callback() = {

  }
  //outline()
  print_toc()
}

#let rules(doc) = {
  doc
}

#let frontmatter_title(ctx: (:), body) = {
  heading(body)
}

#let radial_theme = (rules: rules, frontmatter_title: frontmatter_title)
