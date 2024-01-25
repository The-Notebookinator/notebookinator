#import "../colors.typ": *

#let team(..members) = {
  set align(center)
  grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    ..for member in members.pos() {
      (
        rect(
          fill: surface-1,
          inset: 20pt,
          //width: 200pt,
          //height: 170pt,
          radius: 1.5pt,
        )[
          * #member.name *
          #line(length: 100%, stroke: (cap: "round", dash: "solid", thickness: 1.5pt))
          #v(8pt)
          #grid(
            columns: (1fr, 1fr),
            gutter: 20pt,
            align(center, member.picture),
            align(left, member.about),
          )
        ],
      )
    },
  )
}
