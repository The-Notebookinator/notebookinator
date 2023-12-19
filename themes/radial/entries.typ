#import "./colors.typ": *
#import "./icons/icons.typ"

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

#let frontmatter_entry(context: (:), body) = {
  show: page.with(
    header: [ = Frontmatter header],
    footer: [Frontmatter footer],
  )

  body
}

#let body_entry(context: (:), body) = {
  show: page.with(
    header: [ = Body header],
    footer: [Body footer],
  )

  body
}
#let appendix_entry(context: (:), body) = {
  show: page.with(
    header: [ = Appendix header],
    footer: [Appendix footer],
  )

  body
}
