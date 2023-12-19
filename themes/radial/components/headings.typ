#import "../colors.typ": *

#let heading(it) = {
  // TODO: move highlight to a single spot, rn I have like 5 of them
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

  if it.level == 1 {
    set text(size: 15pt)
    highlight(color: surface_3)[
      #box(baseline: 130%, it.body)
    ]
  } else if it.level == 2 {
    set text(size: 14pt)
    it.body
  } else if it.level == 3 {
    set text(size: 11pt)
    it.body
  }
  linebreak()
}
