#import "../colors.typ": *
#import "/utils.typ"

#import "/packages.typ": tablex
#import tablex: *

/// A decision matrix table.
///
/// Example Usage:
/// ```typ
/// #decision-matrix(
///   properties: (
///     (name: "Versatility", weight: 2),
///     (name: "Flavor", weight: 6),
///     (name: "Crunchiness"), // Defaults to a weight of 1
///   ),
///   ("Sweet potato", 2, 5, 1),
///   ("Red potato", 2, 1, 3),
///   ("Yellow potato", 2, 2, 3),
/// )
/// ```
///
/// - properties (array): A list of the properties that each choice will be rated by
/// - ..choices (array): An array containing the name of the choices as its first member,
/// and values for each of the properties at its following indices
/// -> content
#let decision-matrix(properties: none, ..choices) = {
  let data = utils.calc-decision-matrix(properties: properties, ..choices)
  let columns = for _ in range(properties.len() + 2) {
    (1fr,)
  }

  let title-cell(body) = cellx(fill: surface-2, inset: 0.8em, [
    #set text(13pt)
    #set align(center)
    #body
  ])

  let body-cell(total: false, highest: none, body) = cellx(
    fill: if highest == none { white } else if highest and total { decision-green } else if highest { pro-green } else { white },
    inset: 0.8em,
    [
      #set align(center)
      #body
    ],
  )

  let weight-vline = vlinex(start: data.len() + 1, stroke: gray, expand: -1pt)
  let weight-hline = hlinex(start: 1, end: properties.len() + 1, stroke: gray)

  tablex(
    auto-lines: false,
    columns: columns,
    header-rows: 99, // https://github.com/PgBiel/typst-tablex/issues/4
    hlinex(),
    // All of the vertical lines
    ..for _ in range(properties.len() + 3) {
      (vlinex(end: data.len() + 1),)
    },
    // Title row
    title-cell[],
    ..for property in properties {
      (title-cell(property.name),)
    },
    hlinex(),
    title-cell[Total],
    // Choice values
    ..for choice in data {
      (body-cell(choice.name), ..for property in properties {
        (body-cell(
          highest: choice.values.at(property.name).highest,
          choice.values.at(property.name).value,
        ),)
      }, body-cell(
        total: true,
        highest: choice.values.total.highest,
        choice.values.total.value,
      ), hlinex(),)
    },
    body-cell[],
    ..for property in properties {
      (weight-vline, body-cell[
        #property.at("weight", default: 1)x
      ],)
    },
    weight-vline,
    weight-hline,
  )
}
