#import "rules.typ": rules
#import "entries.typ": cover, frontmatter_entry, body_entry, appendix_entry
#import "format.typ": set-margins, set-heading

#let linear_theme = (
  // Global show rules
  rules: rules, cover: cover,
  // Entry pages
  frontmatter_entry: frontmatter_entry, body_entry: body_entry, appendix_entry: appendix_entry,
)