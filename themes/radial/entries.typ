#import "./colors.typ": *
#import "./icons/icons.typ"
#import "./components/title.typ" as components
#import "/utils.typ"
#import "./metadata.typ": entry_type_metadata

// TODO: make an actual cover
#let cover(context: (:)) = [
  #set align(center)
  *Radial Cover*
]

#let frontmatter_entry(context: (:), body) = {
  show: page.with(
    header: components.title(context.title), footer: align(right, counter(page).display("i")),
  )
  body
}

#let body_entry(context: (:), body) = {
  let metadata = entry_type_metadata.at(context.type)
  show: page.with(
    header: components.title(
      beginning: image.decode(
        utils.change_icon_color(raw_icon: metadata.icon, fill: white), height: 1em,
      ), end: context.start_date.display("[year]/[month]/[day]"), color: metadata.color, context.title,
    ), footer: [
      #line(length: 100%)
      #align(left, [
        *Designed by:* \
        *Witnessed by:*
        #h(1fr) #counter(page).display()
      ])
    ],
  )
  body
}

#let appendix_entry(context: (:), body) = {
  show: page.with(
    header: components.title(context.title), footer: align(right, counter(page).display()),
  )

  body
}
