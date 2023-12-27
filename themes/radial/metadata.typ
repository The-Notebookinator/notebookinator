#import "./icons/icons.typ"
#import "./colors.typ": *

#let entry_type_metadata = (
  "identify": (icon: icons.question_mark, color: yellow),
  "brainstorm": (icon: icons.light_bulb, color: orange),
  "decide": (icon: icons.target, color: blue),
  "build": (icon: icons.hammer, color: red),
  "program": (icon: icons.terminal, color: purple),
  "test": (icon: icons.flask, color: green),
  "management": (icon: icons.bar_chart, color: surface_4),
  "notebook": (icon: icons.page, color: pink),
)

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
