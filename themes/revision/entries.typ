#let frontmatter-entry(ctx: (:), body) = {
  show: page.with(
    header: [ = #ctx.title],
    footer: counter(page).display("i")
  )

  body
}

#let body-entry(ctx: (:), body) = {
  show: page.with(
    header: [ = #ctx.title],
    footer: counter(page).display("1")
  )

  body
}

#let appendix-entry(ctx: (:), body) = {
  show: page.with(
    header: [ = #ctx.title],
    footer: counter(page).display("i")
  )

  body
}

#let cover(ctx: (:)) = [
  #set align(center)

]