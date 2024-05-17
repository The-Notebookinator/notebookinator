#import "./metadata.typ": entry-types
#import "./colors.typ":*
#import "./format.typ": *

#let frontmatter-entry(ctx: (:), body) = {
  show: page.with(
    footer: align(center, context counter(page).display()),
    background: place(rect(fill: gray, height: 100%, width: 15pt)),
  )

  body
}

#let body-entry(ctx: (:), body) = {
  let entry-data = entry-types.at(ctx.type)

  show: page.with(
    header: [
      #grid(
        columns: (1fr, 2fr, 1fr),
        [
          #set text(font: "Tele-Marines", weight: "bold")
          #ctx.team-name
        ], // TODO: get team name from from ctx
        [
          #set align(center)
          #ctx.season
          Engineering Notebook
        ],
        [
          #set align(right)
          #ctx.date.display("[month repr:long] [day padding:none], [year]")
        ],
      )
      #line(length: 100%, stroke: 0.5pt)
    ],
    footer: [
      #line(length: 100%, stroke: 0.5pt)
      #grid(
        columns: (1fr, 0.3fr, 1fr),
        [
          #set text(11pt)
          _All information in this document is property of team #ctx.team-name, unless
          otherwise stated_
        ],
        [
          #set align(center)
          #context counter(page).display()
        ],
        [
          #set align(right)
          *Signature:* #ctx.author
          #linebreak()
          *Witness:* #ctx.witness
        ],
      )
    ],
    background: place[#rect(fill: entry-data.color, height: 100%, width: 15pt)],
  )

  block[
    #title(entry-data.color)[#ctx.title]
    #h(1fr)
    #title(entry-data.color)[#entry-data.title]
  ]

  show image: it => {
    box(stroke: 5pt + entry-data.color, radius: 1em, clip: true, it)
  }

  body
}

// TODO: make an actual appendix entry
#let appendix-entry(ctx: (:), body) = {
  show: page.with(header: [ = Appendix header ], footer: [Appendix footer])

  body
}
