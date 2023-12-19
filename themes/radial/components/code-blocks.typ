#import "../colors.typ": *

#let raw_not_block = box.with(
  fill: surface_2,
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)

#let raw_block(it) = {
  set par(justify: false);
  // the line counter
  let i = 0;
  let box_radius = 1.5pt;

  let detail_radius = 1.5pt;
  let detailRadius = 3pt;
  if (it.lang != none) {
    grid(
      columns: (100%, 100%),
      column-gutter: (-100%),
      block(width: 100%, inset: 1em, {
        for line in it.text.split("\n") {
          box(width: 0pt, align(right, str(i + 1) + h(2em)))
          hide(line)
          linebreak()
          i = i + 1;
        }
      }),
      block(radius: box_radius, fill: surface_1, width: 100%, inset: 1em, {
        place(
          top + right,
          box(fill: surface_3, radius: detail_radius, outset: 3pt, it.lang),
        )
        it
      }),
    )
  } else {
    block(radius: box_radius, fill: surface_2, width: 100%, inset: 1em, it)
  }
}
