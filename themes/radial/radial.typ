#import "/utils.typ": print_toc
#import "./rules.typ": rules
#import "./entries.typ": frontmatter_entry, body_entry, appendix_entry

#let toc() = {
  let callback() = {

  }
  //outline()
  print_toc()
}

#let radial_theme = (
  rules: rules,

  // Entry pages
  frontmatter_entry: frontmatter_entry,
  body_entry: body_entry,
  appendix_entry: appendix_entry,

)
