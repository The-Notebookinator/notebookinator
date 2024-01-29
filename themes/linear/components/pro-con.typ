#let pro-con(pros: [], cons: []) = {
  table(
    columns: (50%, 50%),
    inset: 0.5em,
    fill: (col, row) => 
      if row == 0 {
        if col == 0 {
          dark-green
        }
        if col == 1 {
          dark-red
        } 
      },
    align(
      center, 
      text(
        size: 14pt, 
        weight: "bold", 
        [Pros]
      )),
    align(
      center, 
      text(
        size: 14pt, 
        weight: "bold", 
        [Cons]
      )),
    pros,
    cons
  )
}