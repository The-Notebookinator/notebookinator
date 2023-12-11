#import "./entries.typ": *
#import "./globals.typ": *

/// The entry point for the notebook
#let notebook(
  team_name: "",
  season: "",
  theme: (:),
  body
) = {
  let rules = theme.rules
  show: doc => rules(doc)

  [
    #theme

    #frontmatter_entries
    #entries
    #appendix_entries
  ]

  [
    #print_entries(theme: theme)
  ]
  body
}
