#import "/packages.typ": tablex
#import tablex: *
#import "./colors.typ": *

#let table(it) = {
  tablex(
    columns: it.columns,
    auto-lines: false,
    inset: 10pt,
    fill: (_, row) => {
      if calc.odd(row) { surface-3 }
      if calc.even(row) { surface-1 }
    },
    hlinex(stroke: (cap: "round", thickness: 2pt)),
    ..for child in it.children {
      ([#child],)
    },
    hlinex(stroke: (cap: "round", thickness: 2pt)),
  )
}

// FIXME: the heading currently does not have a newline above it. This means it can be inline if the content above it also doesn't have a newline.
// It would be trivial to add a newline to this, but that looks weird if the above content does actually have a newline
// My proposed solution is to have the heading actually return a heading, but that creates issues when used as a show rule.

#let heading(it) = {
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
    highlight(color: surface-3)[
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

#let raw-not-block = box.with(
  fill: surface-2,
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)

#let raw-block(it) = {
  set par(justify: false);
  // the line counter
  let i = 0;
  let box-radius = 1.5pt;

  let detail-radius = 1.5pt;
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
      block(radius: box-radius, fill: surface-1, width: 100%, inset: 1em, {
        place(
          top + right,
          box(fill: surface-3, radius: detail-radius, outset: 3pt, it.lang),
        )
        it
      }),
    )
  } else {
    block(radius: box-radius, fill: surface-2, width: 100%, inset: 1em, it)
  }
}
