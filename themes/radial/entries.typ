#import "./colors.typ": *
#import "./icons/icons.typ"
#import "./components/components.typ"
#import "./components/title.typ": *
#import "/utils.typ"
#import "./metadata.typ": entry-type-metadata

// TODO: make an actual cover
#let cover = utils.make-cover(ctx => {
  import components: label
  let label = label.with(size: 4.7em, radius: 6pt)

  align(
    center + horizon,
    text(size: 24pt)[
      Radial Theme
    ],
  )

  place(dx: 90pt, dy: -340pt, label("identify"))
  place(dx: 52pt, dy: -295pt, label("brainstorm"))

  place(dx: 520pt, dy: 190pt, label("decide"))
  place(dx: 490pt, dy: 240pt, label("build"))
  place(dx: 460pt, dy: 290pt, label("test"))

  place(
    dx: 150pt,
    dy: -160pt,
    rect(
      width: 50%,
      height: 300pt,
      fill: rgb("#eeeeeeff"),
      radius: (right: 20pt, left: 20pt),
    ),
  )

  place(dx: 125pt, dy: -180pt, label("management"))
  place(dx: 425pt, dy: 105pt, label("management"))

  place(
    dx: 520pt,
    dy: -270pt,
    rect(
      width: 9%,
      height: 55pt,
      fill: rgb("#eeeeeeff"),
      radius: (right: 5pt, left: 5pt),
    ),
  )
  place(
    dx: 455pt,
    dy: -335pt,
    rect(
      width: 9%,
      height: 55pt,
      fill: rgb("#eeeeeeff"),
      radius: (right: 5pt, left: 5pt),
    ),
  )
  place(dx: 490pt, dy: -300pt, label("program"))

  place(
    dx: 55pt,
    dy: 205pt,
    rect(
      width: 9%,
      height: 55pt,
      fill: rgb("#eeeeeeff"),
      radius: (right: 5pt, left: 5pt),
    ),
  )
  place(
    dx: 120pt,
    dy: 275pt,
    rect(
      width: 9%,
      height: 55pt,
      fill: rgb("#eeeeeeff"),
      radius: (right: 5pt, left: 5pt),
    ),
  )
  place(dx: 90pt, dy: 240pt, label("notebook"))

  place(dx: 165pt, dy: 200pt, line(length: 45%, stroke: 3.5pt + black))

  place(dx: 165pt, dy: -215pt, line(length: 45%, stroke: 3.5pt + black))

  place(
    dx: 250pt,
    dy: -280pt,
    text(size: 18pt)[
      *Radial Theme*
    ],
  )

  place(
    dx: 225pt,
    dy: -250pt,
    text(size: 24pt)[
      *[Game Season]*
    ],
  )

  place(
    dx: 235pt,
    dy: 165pt,
    text(size: 24pt)[
      *[Team Name]*
    ],
  )

  place(
    dx: 0pt,
    dy: -370pt,
    figure(
      image("Mediamodifier-Design.svg", width: 118%),
    ),
  )



})


#let frontmatter-entry = utils.make-frontmatter-entry((ctx, body) => {
  show: page.with(
    header: title(ctx.title),
    footer: align(right, context counter(page).display("i")),
  )
  body
})

#let body-entry = utils.make-body-entry((ctx, body) => {
  let metadata = entry-type-metadata.at(ctx.type)
  show: page.with(
    header: components.title(
      beginning: image.decode(
        utils.change-icon-color(raw-icon: metadata.icon, fill: white),
        height: 1em,
      ),
      end: ctx.date.display("[year]/[month]/[day]"),
      color: metadata.color,
      ctx.title,
    ),
    footer: [
      #line(length: 100%)
      #align(
        left,
        [
          *Designed by:* #ctx.author #h(2pt) \
          *Witnessed by:* #ctx.witness
          #h(1fr) #context counter(page).display()
        ],
      )
    ],
  )
  body
})

#let appendix-entry = utils.make-appendix-entry((ctx, body) => {
  show: page.with(
    header: title(
      beginning: image.decode(
        utils.change-icon-color(raw-icon: metadata.icon, fill: white),
        height: 1em,
      ),
      end: ctx.date.display("[year]/[month]/[day]"),
      color: metadata.color,
      ctx.title,
    ),
    footer: [
      #line(length: 100%)
      #align(
        left,
        [
          *Designed by:* #ctx.author #h(2pt) \
          *Witnessed by:* #ctx.witness
          #h(1fr) #context counter(page).display()
        ],
      )
    ],
  )
  body
})
