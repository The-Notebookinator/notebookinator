#import "../colors.typ": *
#import "../metadata.typ": *
#import "/utils.typ"

/// A label that corresponds with one of the entry types.
///
/// - type (string): Any of the radial entry types
/// - size (size): The size of the label
/// -> content
#let label(type, size: 0.7em) = {
  let data = entry-type-metadata.at(type)
  let colored-image = utils.change-icon-color(raw-icon: data.icon, fill: white)

  box(fill: data.color, outset: 3pt, radius: 1.5pt)[
    #set align(center + horizon)
    #image.decode(colored-image, height: size)
  ]
}
