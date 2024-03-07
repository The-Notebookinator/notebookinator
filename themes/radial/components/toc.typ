#import "/utils.typ"
#import "../metadata.typ": *
#import "./label.typ" as label-component

/// Print out the table of contents
///
/// Example Usage:
///
/// ```typ
/// #create-frontmatter-entry(title: "Table of Contents")[
///   #components.toc()
/// ]
/// ```
#let toc() = utils.print-toc((frontmatter, body, appendix) => {
  // Resets the styling applied to all other links in this template
  show text: it => {
    set text(fill: black)
    [_ #it _]
  }

  heading(level: 1)[Entries]

  stack(spacing: 1em, ..for (index, entry) in body.enumerate() {
    ([
      #link(label("notebook-body-" + str(index)))[
        #entry.date.display("[year]/[month]/[day]")
        #h(5pt)
        #label-component.label(entry.type)
        #h(5pt)
        #entry.title
        #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
        #entry.page-number
      ]
    ],)
  })

  linebreak()

  heading(level: 1)[Appendix]

  for (index, entry) in appendix.enumerate() {
    link(label("notebook-appendix-" + str(index)))[
      #entry.title
      #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
      #entry.page-number
      #linebreak()
    ]
  }
})
