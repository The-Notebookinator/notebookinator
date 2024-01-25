#import "./components/headings.typ" as components-heading
#import "./components/code-blocks.typ" as components-code
#import "./components/table.typ" as components-table

#let rules(doc) = {
  set text(font: "Calibri", size: 11pt)
  set page("us-letter")

  set footnote.entry(separator: none)

  // Enforce the correct font on Excalidraw drawings
  show image: it => [
    #align(center)[
      #set text(font: "Virgil 3 YOFF")
      #it
    ]
  ]

  show link: it => [
    #text(fill: blue, [ _ #it _ ])
  ]

  show figure: it => align(center)[
    #it.body

    #if it.caption!= none [
      _ #it.caption.body _
    ]
  ]

  set raw(theme: "./radial.tmTheme")
  show raw.where(block: false): components-code.raw-not-block
  show raw.where(block: true): it => components-code.raw-block(it)

  show heading: components-heading.heading

  show table: components-table.table

  // Display the whole document
  doc
}
