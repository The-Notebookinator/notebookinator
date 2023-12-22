#import "./entries.typ": *
#import "./globals.typ": *
#import "./utils.typ"
#import "./themes/themes.typ"

/// The entry point for the notebook
/// - team_name (string): The name of your team.
/// - season (string): The name of the current season
/// - year (string): The year in which the notebook is being written
/// - theme (dictionary): The theme that will be applied to all of the entries
/// - cover (content): the title page of the notebook
/// - body (content): The content of the notebook. This will be ignored. Use the create_entry functions instead.
#let notebook(
  team_name: none, season: none, year: none, cover: none, theme: (:), body,
) = {
  let rules = theme.rules
  show: doc => rules(doc)
  let cover_context = (team_name: team_name, season: season, year: year)
  page(print_cover(context: cover_context, theme: theme))
  page()[] // Filler page

  [
    #print_entries(theme: theme)
  ]
  body
}
