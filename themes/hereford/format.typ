#let rules(
  doc,
) = {
  set page(
    "us-letter",
    margin: (
      top: 2cm,
      x: 1.5cm,
      bottom: 1.5cm,
    ),
  )
  set text(
    font: "Roboto",
    size: 11pt,
  )
  doc
}
