

#let set-margins(x, y) = {
  set line(stroke: 1.5pt)
  let borderTL = 0% + 15%
  let borderTR = 100% - 15%
  place(
    // Left border line
    line(start: (0% + x, 5%), end: (0% + x, 100% - y))
  )
  place(
    // Right border line
    line(start: (100% - x, 5%), end: (100% - x, 100% - y))
  )
  place(
    // Bottom border line
    line(start: (0% + x, 100% - y), end: (100% - x, 100% - y))
  )
  place(
    // Top left border line -> ——
    line(start: (0% + x, 5%), end: (borderTL + x, 5%))
  )
  place(
    // Top right border line -> ——
    line(start: (100% - x, 5%), end: (borderTR - x, 5%))
  )
  place(
    // Top left border line -> ︱
    line(start: (borderTL + x, 4%), end: (borderTL + x, 6%))
  )
  place(
    // Top left border line -> ︱
    line(start: (borderTR - x, 4%), end: (borderTR - x, 6%))
  )
}

#let create-heading(context: (:), color: gray, level: 1) = {
  if level == 1 {
    box(inset: 0.5em, fill: color)[= #context]
    h(5pt)
    box(baseline: -10pt, width: 1fr, line(length: 100%))
  }
  if level == 2 {
    box(inset: 0.5em, fill: color)[== #context]
    h(5pt)
    box(baseline: -10pt, width: 1fr, line(length: 100%))
  }
  if level == 3 {
    box(inset: 0.5em, fill: color)[=== #context]
    h(5pt)
    box(baseline: -10pt, width: 1fr, line(length: 100%))
  }
}