#import "../colors.typ": *

/// The title for an entry. This function is used internally by the theme, and not meant to be called by the user.
///
/// - color (color):
/// - beginning (content):
/// - end (content):
/// - body (content):
/// -> content
#let title(color: gray, beginning: none, end: none, body) = {
  let highlight(color: none, body, width: auto) = {
    box(
      fill: color,
      outset: 5pt,
      radius: 1.5pt,
      body,
      height: 1em,
      width: width,
    )
  }

  set text(size: 18pt, weight: "bold")
  set align(horizon)

  if not beginning == none {
    highlight(color: color, beginning)
    h(15pt)
  }
  highlight(color: color.lighten(80%), width: 1fr)[
    #body
  ]
  if not end == none {
    h(15pt)
    highlight(color: color.lighten(80%), end)
  }
}
