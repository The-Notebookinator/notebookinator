#import "/utils.typ"
#import "../metadata.typ": *
#import "./label.typ": *

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
  heading(level: 1)[Entries]
  linebreak()

  stack(spacing: 1em, ..for entry in body {
    ([
      #entry.date.display("[year]/[month]/[day]")
      #h(5pt)
      #label(label: entry.type)
      #h(5pt)
      #entry.title
      #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
      #entry.page-number
    ],)
  })

  linebreak()
  linebreak()

  heading(level: 1)[Appendix]
  linebreak()

  stack(spacing: 1em, ..for entry in appendix {
    ([
      #entry.title
      #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
      #entry.page-number
    ],)
  })
})
