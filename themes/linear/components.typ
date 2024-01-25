#import "/utils.typ"
#import "./colors.typ": *

// TODO: Move this somewhere
#let entry-type-metadata = (
  "identify": red,
  "brainstorm": yellow,
  "decide": green,
  "build": blue,
  "program": purple,
  "test": pink,
)

#let set-toc() = utils.print-toc(
  (_, body, appendix) => style(
    styles => {
      let previous-date
       
      let toc = stack(
        dir: ttb,
        spacing: 0.3em,
        ..for entry in body {
          let date-content = if entry.date == previous-date {} else {
            box(inset: 5pt, fill: white, entry.date.display("[day]/[month]/[year]"))
          }
           
          previous-date = entry.date
          ([
            // Single line content
            #box(baseline: 0.35em, width: 5em)[
              #set align(center)
              #date-content
            ]
            #h(1em)
            #box(
              fill: entry-type-metadata.at(entry.type),
              inset: (x: .4em, y: .6em),
              baseline: 25%,
            )[#entry.title #h(1.4em)]
            #h(1em)
            #box(width: 1fr, line(length: 100%, start: (0pt, -.35em)))
            #h(1em)
            #entry.page-number
          ],)
        },
      )
       
      let height = measure(toc, styles).height
       
      box[
        #place(
          top + left,
          dx: 2.5em,
          dy: 1em,
          line(angle: 90deg, length: height - 12pt),
        )
        #toc
      ]
    },
  ),
)

#let set-glossary() = utils.print-glossary(
  glossary => {
    stack(
      dir: ttb,
      spacing: 45in,
      ..for entry in glossary {([
        #box(inset: 0.5em, fill: gray)[= #entry.word]
        #h(5pt)
        #box(baseline: -10pt, width: 1fr, line(length: 100%))

        #entry.definition

      ],)}
    ) 
  }
)

#let pro-con() = {
  table(
    columns: (50%, 50%),
    inset: 0.5em,
    [Pros], [Cons],
    // Pros
    
    // Cons
  )
}