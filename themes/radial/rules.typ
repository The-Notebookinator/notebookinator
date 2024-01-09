#import "./components/headings.typ" as components_heading
#import "./components/code-blocks.typ" as components_code


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
    _ #it.caption.body _
  ]

  show raw.where(block: false): components_code.raw_not_block
  show raw.where(block: true): it => components_code.raw_block(it)

  show heading: components_heading.heading

  // Display the whole document
  doc
}
