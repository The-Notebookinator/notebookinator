#import "@preview/tablex:0.0.8": *
#import "../colors.typ": *

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
