#import "./entries.typ": *
#import "./themes/themes.typ": *
#import "./globals.typ": *


/// The entry point for the notebook
#let notebook(
  team_name: "",
  season: "",
  theme: "default",
  body
) = {
  [
    #frontmatter_entries
    #entries
    #appendix_entries
  ]

  print_entries()

  body
}
