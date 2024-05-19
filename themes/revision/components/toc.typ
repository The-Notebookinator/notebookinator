#import "/utils.typ"
#import "/themes/revision/colors.typ": *
#import "header.typ": header-map

#let toc() = utils.print-toc((frontmatter, body, appendix) => {
  let last-page = 0
  
  stack(
    spacing: none,
    [#heading(level: 1)[ENTRIES] #v(1em)],
    [#grid(
      rows: 1em,
      columns: (1fr, 10fr, 2fr),
      align(center)[PAGE],
      align(center)[SUBJECT],
      align(center)[DATE]
    )],
    ..for entry in body {
      if entry.at("page-number") - last-page > 1 {
        for i in range(entry.at("page-number") - last-page - 1) {
          ([#table(
              stroke: (luma(120) + .5pt),
            rows: (auto),
            columns: (1fr, 10fr, 2fr),
            align(center)[#(last-page + i + 1)],
            [#place(dy: -4.7pt, dx: +40pt)[#line(angle:90deg, length: 17.3pt, stroke: (2pt + black))]]
          )],)
        }
      }
      ([#table(
        stroke: (luma(120) + .7pt),
        rows: (auto),
        columns: (1fr, 10fr, 2fr),
        align(center)[#entry.at("page-number")],
        if entry.at("type") != none {
          align(left)[#header-map.at(entry.at("type")): #entry.at("title")]
        } else {
          align(left)[#entry.at("title")]
        },
        align(center)[#entry.at("date").display("[month]/[day]/[year]")]
      )],)

      last-page = entry.at("page-number")
    },
    [#v(2em) #heading(level: 1)[APPENDIX] #v(1em)],
    [#grid(
      rows: 1em,
      columns: (1fr, 10fr, 2fr),
      align(center)[PAGE],
      align(center)[SUBJECT],
      align(center)[DATE]
    )],
    ..for entry in appendix {
      ([#table(
        rows: (auto),
        columns: (1fr, 10fr, 2fr),
        align(center)[#numbering("I", entry.at("page-number"))],
        align(left)[#entry.at("title")],
        align(center)[#entry.at("date").display("[month]/[day]/[year]")]
      )],)
    }
  )
})