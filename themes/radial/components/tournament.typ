#import "../colors.typ": *

/// A Series of tables displaying match data from a tournament. Useful for tournament analysis entries.
///
/// - match (string): The name of the match
/// - red_alliance (dictionary): The red alliance
/// - blue_alliance (dictionary): The blue alliance
/// - won (boolean): Whether you won the match
/// - auton (boolean): Whether you got the autonomous bonus
/// - awp (boolean): Whether you scored the autonomous win point
/// - notes (content): Any additional notes you have about the match
/// -> content
#let tournament(matches: ((
  match: "",
  red_alliance: (teams: ("", ""), score: 0),
  blue_alliance: (teams: ("", ""), score: 0),
  won: false,
  auton: false,
  awp: false,
  notes: [],
),)) = {
  for match in matches {
    let color = if match.won { green } else { red }
    let cell = rect.with(fill: color.lighten(80%), width: 100%, height: 30pt)
    let header_cell = cell.with(fill: color, height: 20pt)
    let alliance_info(alliance: none) = {
      cell[
        #grid(columns: (1fr, 1fr), [
          #alliance.teams.at(0) \
          #alliance.teams.at(1) \
        ], [
          #set text(size: 15pt)
          #set align(horizon + center)
          #alliance.score
        ])
      ]
    }

    let bool_icon(input) = {
      cell[
        #set align(horizon + center)
        #if input { image("/template/icons/check.svg", width: 1.5em) } else { image("/template/icons/x.svg", width: 1.5em) }
      ]
    }

    grid(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr),
      header_cell(radius: (top-left: 1.5pt))[*Match*],
      header_cell[*Red Alliance*],
      header_cell[*Blue Alliance*],
      header_cell[*Auton Bonus*],
      header_cell(radius: (top-right: 1.5pt))[*AWP*],
      cell[#match.match],
      alliance_info(alliance: match.red_alliance),
      alliance_info(alliance: match.blue_alliance),
      bool_icon(match.auton),
      bool_icon(match.awp),
    )

    if not match.at("notes", default: none) == none [
      === Notes

      #match.notes
    ] else [

    ]
  }
}
