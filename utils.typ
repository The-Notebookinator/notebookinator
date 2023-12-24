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
