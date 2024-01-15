#import "../colors.typ": *
#import "/utils.typ"

#import "@preview/tablex:0.0.5": *

/// A decision matrix table.
///
/// - properties (array): A list of the properties that each choice will be rated by
/// - ..choices (array): An array containing the name of the choices as its first member,
/// and values for each of the properties at its following indices
/// -> content
#let decision-matrix(properties: none, ..choices) = {
  let data = utils.calc-decision_matrix(properties: properties, ..choices)

  set align(center)

  tablex(
    auto-lines: false, columns: properties.len() + 2, fill: (_, row) => {
      if calc.odd(row) { surface-3 }
      if calc.even(row) { surface-1 }
    },
    // Top line
    hlinex(stroke: (cap: "round", thickness: 2pt)),
    // Blank column to account for names of choices
    [],
    // Print out all the properties
    ..for property in properties {
      ([ *#property* ],)
    },
    // Last box in the row
    [*Total*],
    // Print out the data for each choice
    ..for choice in data {
      // Override the fill if the choice has the highest score
      let cell = if choice.highest { cellx.with(fill: green) } else { cellx }
      (cell[*#choice.name*], ..for value in choice.values {
        (cell[#value],)
      }, cell[#choice.total])
    },
    // Bottom line
    hlinex(stroke: (cap: "round", thickness: 2pt)),
  )
}
