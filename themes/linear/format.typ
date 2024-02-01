#import "entry-types.typ": *
/// Sets the length and width of the margins
///
/// Example Usage:
///
/// ```typ
/// #set-margins(8%, 15%)
/// ```
/// 
/// - x (size, ratio): the distance from the edge of the page to the left and right margins
/// - y (size, ratio): the distance from the edge of the page to the bottom margin
/// -> content
#let set-margins(x, y) = {
  set line(stroke: 1.5pt)
  // TL: top left
  // TR: top right
  let border-TL = 0% + 15%
  let border-TR = 100% - 15%
  place(
    // Left border line
    line(start: (0% + x, 5%), end: (0% + x, 100% - y)),
  )
  place(
    // Right border line
    line(start: (100% - x, 5%), end: (100% - x, 100% - y)),
  )
  place(
    // Bottom border line
    line(start: (0% + x, 100% - y), end: (100% - x, 100% - y)),
  )
  place(
    // TL border line -> ——
    line(start: (0% + x, 5%), end: (border-TL + x, 5%)),
  )
  place(
    // TR border line -> ——
    line(start: (100% - x, 5%), end: (border-TR - x, 5%)),
  )
  place(
    // TL border line -> ︱
    line(start: (border-TL + x, 4%), end: (border-TL + x, 6%)),
  )
  place(
    // TR border line -> ︱
    line(start: (border-TR - x, 4%), end: (border-TR - x, 6%)),
  )
}

#let set-heading(it, type) = {
  show: block
  let color = entry-type-metadata.at(type)
  
  if it.level == 1 {
    set text(18pt)
  } 
  if it.level == 2 {
    set text(15pt)
  }
  if it.level == 3 {
    set text(13pt)
  } else {
    set text(11pt)
  } 
  
  set text(weight: "regular")
   
  box(inset: 0.5em, fill: color)[#it.body]
  h(5pt)
  box(baseline: -10pt, width: 1fr, line(length: 100%))
}
