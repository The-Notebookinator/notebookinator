#import "./entries.typ": *
#import "./globals.typ": *
#import "./utils.typ"
#import "./themes/themes.typ"

/// The entry point for the notebook
/// - team_name (string): The name of your team.
/// - season (string): The name of the current season
/// - theme (dictionary): The theme that will be applied to all of the entries
/// - body (content): The content of the notebook. This will be ignored. Use the create_entry functions instead.
#let notebook(team_name: "", season: "", theme: (:), body) = {
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
