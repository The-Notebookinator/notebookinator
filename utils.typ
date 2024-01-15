#import "/globals.typ"

// TODO: document what context provides to the callback

/// Utility function to help themes implement a table of contents.
///
/// Example Usage:
/// ```typ
/// utils.print-toc(context => [
///   #context.title
///   #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
///   #context.page-number
/// ])
/// ```
/// - type (string): Takes either "frontmatter", "body", or "appendix"
/// - callback (function): A function which takes the #link(<context>)[context] of the entry as input, and returns the content for a single row
/// -> content
#let print-toc(type: "body", callback) = {
  locate(
    loc => {
      // Each of the types of entries have their own state variable and label, so we need to decide which ones to use
      let (state, markers) = if type == "frontmatter" {
        (
          globals.frontmatter-entries, query(selector(<notebook-frontmatter>), loc),
        )
      } else if type == "body" {
        (globals.entries, query(selector(<notebook-body>), loc))
      } else if type == "appendix" {
        (globals.appendix-entries, query(selector(<notebook_appendix>), loc))
      } else {
        panic("No valid entry type selected.")
      }

      for (index, entry) in state.final(loc).enumerate() {
        let page-number = counter(page).at(markers.at(index).location()).at(0)
        let context = entry.context
        context.page-number = page_number
        [
          #callback(context) \
        ]
      }
    },
  )
}

// TODO: document what data the callback has access to

/// A utility function meant to help themes implement a glossary
/// - callback (function): A function returning the content of a single glossary entry
/// -> content
#let print-glossary(callback) = locate(
  loc => {
    let sorted-glossary = globals.glossary_entries.final(loc).sorted(key: ((word, _)) => word)
    for entry in sorted-glossary {
      box(callback(entry))
    }
  },
)

/// A utility function that does the calculation for decision matrices for you
///
/// Example Usage:
///
/// ```typ
/// #calc-decision_matrix(
///   properties: ("Versatility", "Flavor", "Chrunchiness"),
///   ("Sweet potato", 2, 5, 1),
///   ("Red potato", 2, 1, 3),
///   ("Yellow potato", 2, 2, 3),
/// )
/// ```
///
/// The function returns an array of dictionaries, one for each choice. Each dictionary contains the name of the choice,
/// the values for each property, the total, and whether the choice has the highest score or not. Here's an example of what one of these dictionaries might look like:
///
/// ```typ
///   #(
///     name: "Sweet potato",
///     values: (2, 5, 1),
///     total: 8,
///     highest: true,
///   )
/// ```
///
/// - properties (array string): A list of the properties that each choice will be rated by
/// - ..choices (array): All of the choices that are being rated. The first element of the array should be the name of the
/// -> array
#let calc-decision_matrix(properties: (), ..choices) = {
  for choice in choices.pos() {
    assert(choice.len() - 1 == properties.len())
  }

  let result = ();
  let highest = (index: 0, value: 0)

  for (index, choice) in choices.pos().enumerate() {
    let name = choice.at(0)
    let values = choice.slice(1)
    let total = values.sum()

    if total > highest.value {
      highest.index = index
      highest.value = total
    }
    let entry = (name: name, values: values, total: total, highest: false)
    result.push(entry)
  }
  result.at(highest.index).highest = true;

  return result
}

/// Returns the raw image data, not image content
/// You'll still need to run image.decode on the result
///
/// - raw-icon (string): The raw data for the image. Must be svg data.
/// - fill (color): The new icon color
/// -> string
#let change-icon-color(raw-icon: "", fill: red) = {
  return raw-icon.replace("<path", "<path style=\"fill: " + fill.to-hex() + "\"")
}

/// Takes the path to an icon as input, recolors that icon, and then returns the decoded image as output.
///
/// - path (string): The path to the icon. Must point to a svg.
/// - fill (color): The new icon color.
/// - width (ratio length): Width of the image
/// - height (ratio length): height of the image
/// - fit (string): How the image should adjust itself to a given area. Takes either "cover", "contain", or "stretch"
/// -> content
#let colored-icon(path, fill: red, width: 100%, height: 100%, fit: "contain") = {
  let raw-icon = read(path)
  let raw-colored_icon = raw-icon.replace("<path", "<path style=\"fill: " + fill.to-hex() + "\"")
  return image.decode(raw-colored_icon, width: width, height: height, fit: fit)
}
