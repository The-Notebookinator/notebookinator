#import "/utils.typ"
#import "../metadata.typ": *

/// Print out the table of contents
///
/// Example Usage:
///
/// ```typ
/// #create-frontmatter-entry(title: "Table of Contents")[
///   #components.toc()
/// ]
/// ```
#let toc() = {
  let label(label: "", size: 0.7em) = {
    let data = entry-type-metadata.at(label)
    let colored-image = utils.change-icon-color(raw-icon: data.icon, fill: white)

    box(fill: data.color, outset: 3pt, radius: 1.5pt)[
      #set align(center + horizon)
      #image.decode(colored-image, height: size)
    ]
  }

  heading(level: 1)[Entries]

  linebreak()

  utils.print-toc(context => [
    #let end-date = context.end-date.display("[year]/[month]/[day]")
    #let start-date = context.start-date.display("[year]/[month]/[day]")
    #end-date#h(5pt)
    #label(label: context.type)
    #h(5pt)
    #context.title
    #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
    #context.page-number
  ])

  linebreak()

  heading(level: 1)[Appendix]

  linebreak()

  utils.print-toc(type: "appendix", context => [
    #context.title
    #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
    #context.page-number
  ])
}
