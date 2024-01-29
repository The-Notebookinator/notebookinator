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

#let set-heading(it, type) = {
  let color = if type == "identify" {
    red
  } else if type == "brainstorm" {
    orange
  } else if type == "decide" {
    green
  } else if type == "build" {
    blue
  } else if type == "program" {
    purple
  } else if type == "test" {
    rgb("#DDB0EB")
  }
  if it.level == 1 {
    set text(18pt)
  } 
  if it.level == 2 {
    set text(15pt)
  }
  if it.level == 3 {
    set text(13pt)
  }
  box(inset: 0.5em, fill: color)[#it]
  h(5pt)
  box(baseline: -10pt, width: 1fr, line(length: 100%))
}