#import "/globals.typ"

// TODO: document what context provides to the callback

/// Utility function to help themes implement a table of contents.
///
/// Example Usage:
/// ```typ
/// #let toc() = utils.print-toc((frontmatter, body, appendix) => {
///   for entry in body [
///     #entry.title
///     #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
///     #entry.page-number
///   ]
/// })
/// ```
/// - callback (function): A function which takes the #link(<context>)[context] of all entries as input, and returns the content of the entire table of contents.
/// -> content
#let print-toc(callback) = locate(
  loc => {
    // Each of the types of entries have their own state variable and label, so we need to decide which ones to use
    let helper(type) = {
      let (state, markers) = if type == "frontmatter" {
        (
          globals.frontmatter-entries,
          query(selector(<notebook-frontmatter>), loc),
        )
      } else if type == "body" {
        (globals.entries, query(selector(<notebook-body>), loc))
      } else if type == "appendix" {
        (globals.appendix-entries, query(selector(<notebook-appendix>), loc))
      } else {
        panic("No valid entry type selected.")
      }

      let result = ()

      for (index, entry) in state.final(loc).enumerate() {
        let page-number = counter(page).at(markers.at(index).location()).at(0)
        let context = entry.context
        context.page-number = page-number
        result.push(context)
      }
      return result
    }

    let frontmatter-entries = helper("frontmatter")
    let body-entries = helper("body")
    let appendix-entries = helper("appendix")

    callback(frontmatter-entries, body-entries, appendix-entries)
  },
)

/// A utility function meant to help themes implement a glossary
/// - callback (function): A function that returns the content of the glossary
/// -> content
#let print-glossary(callback) = locate(
  loc => {
    let sorted-glossary = globals.glossary-entries.final(loc).sorted(key: ((word, _)) => word)
    callback(sorted-glossary)
  },
)

/// A utility function that does the calculation for decision matrices for you
///
/// Example Usage:
///
/// ```typ
/// #calc-decision-matrix(
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
#let calc-decision-matrix(properties: (), ..choices) = {
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
  let raw-colored-icon = raw-icon.replace("<path", "<path style=\"fill: " + fill.to-hex() + "\"")
  return image.decode(raw-colored-icon, width: width, height: height, fit: fit)
}
