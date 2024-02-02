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
/// The function returns an array of dictionaries, one for each choice.
/// Here's an example of what one of these dictionaries might look like:
///
/// ```typ
/// #(name: "Sweet potato", values: (
///   Versatility: (value: 3, highest: true),
///   Flavor: (value: 1, highest: false),
///   Crunchiness: (value: 1, highest: false),
///   total: (value: 5, highest: false),
/// )),
/// ```
/// - properties (array string): A list of the properties that each choice will be rated by
/// - ..choices (array): All of the choices that are being rated. The first element of the array should be the name of the
/// -> array
#let calc-decision-matrix(properties: (), ..choices) = {
  for choice in choices.pos() {
    assert(
      choice.len() - 1 == properties.len(),
      message: "The number of supplied values did not match the number of properties.",
    )
  }

  // This function follows the follow steps to calculate the outcome of a decision matrix:
  // 1. Applies all of the weights to each of the values
  // 2. Calculates the total for each choice
  // 3. Adds all of the values to a dictionary, labeling them with their respective property names
  // 4. Iterates over each of the newly organized choices to determine which is the highest for each category (including the total)
  let choices = choices.pos().enumerate().map(
    ((index, choice)) => {
      let name = choice.at(0)
      let values = choice.slice(1)

      // 1.  Weight the values
      values = values.enumerate().map(
        ((index, value)) => value * properties.at(index).at("weight", default: 1),
      )

      // 2. Calc total
      let total = values.sum()

      // 3. Assign the value names
      let result = (:)
      for (index, value) in values.enumerate() {
        result.insert(properties.at(index).name, (value: value, highest: false))
      }
      result.insert("total", (value: total, highest: false))

      (name: name, values: result)
    },
  )

  // 4. Check if highest
  properties.push((name: "total")) // Treat total as a property as well
  for property in properties {
    let highest = (index: 0, value: 0) // Records the index of the choice which had the highest total

    for (index, choice) in choices.enumerate() {
      let property-value = choice.values.at(property.name).value

      if property-value > highest.value {
        highest.index = index
        highest.value = property-value
      }
    }
    choices.at(highest.index).values.at(property.name).highest = true;
  }

  return choices
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
