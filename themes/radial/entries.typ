#import "./colors.typ": *
#import "./icons/icons.typ"
#import "./components/components.typ"
#import "/utils.typ"
#import "./metadata.typ": entry_type_metadata

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
      beggining: image.decode(utils.change_icon_color(raw_icon: metadata.icon, fill: white), height: 1em),
      end: [#context.start_date.display()],
      color: metadata.color,
      context.title,
      ),
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
