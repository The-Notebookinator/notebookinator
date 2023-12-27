#import "./rules.typ": rules
#import "./entries.typ": cover, frontmatter_entry, body_entry, appendix_entry
#import "./components/components.typ"

#let radial_theme = (
  // Global show and set rules
  rules: rules,
  cover: cover,

  // Entry pages
  frontmatter_entry: frontmatter_entry,
  body_entry: body_entry,
  appendix_entry: appendix_entry
)
