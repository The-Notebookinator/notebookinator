#let cover(ctx: (:)) = {}

#let frontmatter-entry(ctx: (:), body) = {
  show: page.with(
  margin: (
    top: 5em,
  ),
  header: {
    place(top + right, dx: 100pt, box(width: 250%, height: 100%, fill: gray))
    set align(center + horizon)
    box(radius: 0.3em, width: 200pt, outset: 9pt, fill: gray.darken(20%), [*#ctx.title*])
  }
  )

  body
}

#let body-entry(ctx: (:), body) = {
  show: page.with(
    header: [ = #ctx.title
      #box(width: 1fr, line(length: 100%)) ],
    footer: align(center, counter(page).display()),
  )

  body
}
#let appendix-entry(ctx: (:), body) = {
  show: page.with(
    header: [ = #ctx.title
      #box(width: 1fr, line(length: 100%)) ],
    footer: align(center, counter(page).display()),
  )

  body
}
