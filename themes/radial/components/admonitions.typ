#import "../colors.typ": *
#import "../icons/icons.typ"
#import "/utils.typ"
#import "@preview/showybox:2.0.1": showybox

#let admonition_type_metadata = (
  "note": (icon: icons.pencil, color: green, title: "Note"),
  "warning": (icon: icons.warning, color: red, title: "Warning"),
  "example": (icon: icons.web, color: purple, title: "Example"),
  "quote": (icon: icons.quotes, color: gray, title: "Quote"),
  "equation": (icon: icons.function, color: orange, title: "Equation"),
  "decision": (
    icon: icons.target,
    color: blue,
    title: "Final Decision",
  ),
  "build": (
    icon: icons.hammer,
    color: red,
    title: "Build Complete",
  ),
)

/// A message in a colored box meant to draw the reader's attention.
///
/// - type (string): The type of admonition.
///   Available types include:
///   - "note"
///   - "example"
///   - "quote"
///   - "equation"
///   - "decision"
///   - "build"
/// - body (content): The content of the admonition
/// -> content
#let admonition(type: none, body) = {
  let info = admonition_type_metadata.at(type)
  let colored_icon = utils.change_icon_color(raw_icon: info.icon, fill: info.color)

  showybox(
    frame: (
      border-color: info.color,
      body-color: info.color.lighten(80%),
      thickness: (left: 4pt),
      radius: 1.5pt,
    ),
    [
      #text(
        size: 15pt,
        fill: info.color,
        [
          #box(baseline: 30%, image.decode(colored_icon, width: 1.5em)) *#info.title*
        ],
      )
      \
      #body
    ],
  )
}
