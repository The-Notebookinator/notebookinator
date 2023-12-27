#import "/utils.typ": print_toc
#import "./rules.typ": rules
#import "./entries.typ": frontmatter_entry, body_entry, appendix_entry
#import "./components/components.typ"

#let cover(context: (:)) = [
  #set align(center)
  *Radial Cover*
]

#let radial_theme = (
  // Global show and set rules
  rules: rules, cover: cover,
  // Entry pages
  frontmatter_entry: frontmatter_entry, body_entry: body_entry, appendix_entry: appendix_entry,
)
