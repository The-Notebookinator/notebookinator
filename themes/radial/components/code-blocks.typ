#import "../colors.typ": *

#let raw-not-block = box.with(
  fill: surface-2, inset: (x: 3pt, y: 0pt), outset: (y: 3pt), radius: 2pt,
)

#let raw-block(it) = {
  set par(justify: false);
  // the line counter
  let i = 0;
  let box-radius = 1.5pt;

  let detail-radius = 1.5pt;
  if (it.lang != none) {
    grid(
      columns: (100%, 100%), column-gutter: (-100%), block(width: 100%, inset: 1em, {
        for line in it.text.split("\n") {
          box(width: 0pt, align(right, str(i + 1) + h(2em)))
          hide(line)
          linebreak()
          i = i + 1;
        }
      }), block(
        radius: box-radius, fill: surface-1, width: 100%, inset: 1em, {
          place(
            top + right, box(fill: surface-3, radius: detail-radius, outset: 3pt, it.lang),
          )
          it
        },
      ),
    )
  } else {
    block(radius: box-radius, fill: surface-2, width: 100%, inset: 1em, it)
  }
}
