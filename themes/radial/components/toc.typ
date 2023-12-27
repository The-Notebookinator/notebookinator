#import "/utils.typ"
#import "../metadata.typ": *

/// Print out the table of contents
/// -> content
#let toc() = {
  let label(label: "", size: 0.7em) = {
    let data = entry_type_metadata.at(label)
    let colored_image = utils.change_icon_color(raw_icon: data.icon, fill: white)

    box(fill: data.color, outset: 3pt, radius: 1.5pt)[
      #set align(center + horizon)
      #image.decode(colored_image, height: size)
    ]
  }

  heading(level: 1)[Entries]

  linebreak()

  utils.print_toc(context => [
    #let end_date = context.end_date.display("[year]/[month]/[day]")
    #let start_date = context.start_date.display("[year]/[month]/[day]")
    #end_date#h(5pt)
    #label(label: context.type)
    #h(5pt)
    #context.title
    #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
    #context.page_number
  ])

  linebreak()

  heading(level: 1)[Appendix]

  linebreak()

  utils.print_toc(type: "appendix", context => [
    #context.title
    #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
    #context.page_number
  ])
}
