#import "../colors.typ": *

#let title(color: gray, beggining: none, end: none, body) = {
  let highlight(color: none, body, width: auto) = {
    box(
      fill: color,
      outset: 5pt,
      radius: 1.5pt,
      body,
      height: 1em,
      width: width,
    )
  }

  set text(size: 18pt, weight: "bold")
  set align(horizon)

  if not beggining == none {
    highlight(color: color)[
      #beggining
    ]
    h(15pt)
  }
  highlight(color: color.lighten(80%), width: 1fr)[
    #body
  ]
  if not end == none {
    h(15pt)
    highlight(color: color.lighten(80%))[
      #end
    ]
  }
}
