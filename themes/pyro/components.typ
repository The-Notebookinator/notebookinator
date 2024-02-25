#import "/utils.typ"
#import "./format.typ": *
#import "./metadata.typ": *
#import "/packages.typ": tablex
#import tablex: *

#let toc() = utils.print-toc(
  (frontmatter, body, appendix) => {
    heading[Contents]

    stack(
      spacing: 1em,
      ..for entry in body {
        (
          [
            #let entry-data = entry-types.at(entry.type)
            #box(baseline: 25%)[#title(entry-data.color, entry.title)]
            #h(1em)
            #box(
              width: 1fr,
              line(length: 100%, start: (0pt, -.35em), stroke: (dash: "loosely-dotted")),
            )
            #h(1em)
            #entry.page-number

          ],
        )
      },
    )
  },
)

#let decision-matrix(properties: none, ..choices) = {
  let data = utils.calc-decision-matrix(properties: properties, ..choices)
  let body-cell = box.with(width: 100%, inset: 5pt)
  let top-left-corner-cell = body-cell.with(radius: 5pt)
  let top-right-corner-cell = body-cell.with(radius: 50pt, fill: red)
  grid(
    inset: -0.1pt,
    columns: for _ in range(properties.len() + 2) {
      (1fr,)
    }, //
    fill: (col, row) => {
      if col == 0 and row == 0 { white }
      else if calc.odd(row) { surface-3 }
      else if calc.even(row) { surface-1 }
    },
    body-cell[],
    //body-cell[*Weight*],
    ..for property in properties {
      (body-cell[ *#property.name* ],)
    },
    top-right-corner-cell[*Total*],
    ..for choice in data {
      //Override the fill if the choice has the highest score
      //let cell = if choice.values.total.highest { cellx.with(fill: green) } else { cellx }
      (body-cell[*#choice.name*], ..for value in choice.values {
        (body-cell[#value.at(1).value],)
      })
    },
  )
}
