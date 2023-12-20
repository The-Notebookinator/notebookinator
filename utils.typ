#import "/globals.typ"
/// Utility function to help themes implement a table of contents
///
/// - type (string): Takes either "frontmatter", "body", or "appendix"
/// - callback (function): A function which takes the context of the entry as input, and returns the content for a single row
#let print_toc(type: "body", callback) = {
  locate(
    loc => {
      // Each of the types of entries have their own state variable and label, so we need to decide which ones to use
      let (state, headings) = if type == "frontmatter" {
        (globals.frontmatter_entries, query(selector(<nb_frontmatter>), loc))
      } else if type == "body" {
        (globals.entries, query(selector(<nb_body>), loc))
      } else if type == "appendix" {
        (globals.appendix_entries, query(selector(<nb_appendix>), loc))
      } else {
        panic("No valid entry type selected.")
      }

      for (index, entry) in state.final(loc).enumerate() {
        let page_number = counter(page).at(headings.at(index).location()).at(0)
        let context = entry
        context.page_number = page_number
        [
          #callback(context) \
        ]
      }
    },
  )
}

#let calc_decision_matrix() = {}

/// Returns the raw image data, not image content
/// You'll still need to run image.decode on the result
///
/// - raw_icon (string): The raw data for the image. Must be svg data.
/// - fill (color): The new icon color
/// -> string
#let change_icon_color(raw_icon: "", fill: red) = {
  return raw_icon.replace("<path", "<path style=\"fill: " + fill.to-hex() + "\"")
}

/// Takes the path to an icon as input, recolors that icon, and then returns the decoded image as output.
///
/// - path (string): The path to the icon. Must point to a svg.
/// - fill (color): The new icon color.
/// -> function
#let colored_icon(path, fill: red) = {
  let raw_icon = read(path)
  let raw_colored_icon = change_icon_color(raw_icon)
  return image.decode.with(raw_colored_icon)
}
