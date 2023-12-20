#import "./colors.typ": *
#import "./icons/icons.typ"
#import "./components/components.typ"
#import "/utils.typ"

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
    header: components.title(
      )[#context.title],
    footer: align(right)[#counter(page).display("i")],
  )
  body
}

#let body_entry(context: (:), body) = {
  let metadata = entry_type_metadata.at(context.type)
  show: page.with(
    header: components.title(
      beggining: image.decode(utils.change_icon_color(raw_icon: metadata.icon, fill: white), height: 1em)
,
      end: [#context.start_date.display()],
      color: metadata.color
      )[Body],
    footer: [
      #line(length: 100%)
        #align(left, [
         *Designed by:* \
         *Witnessed by:* #h(1fr) #counter(page).display()
         ])
       ],
  )
  body
}

#let appendix_entry(context: (:), body) = {
  show: page.with(
    header: components.title(context.title),
    footer: align(right, counter(page).display()),
  )

  body
}
