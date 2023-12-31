#import "/globals.typ"
#import "./utils.typ"
#import "./themes/themes.typ"

/// Generic entry creation function.
///
/// - entry_type (string): The type of entry. Takes either "frontmatter", "body", or "appendix".
/// - title (string): The title of the entry.
/// - type (string): The type of entry. The possible values for this are decided by the theme.
/// - start_date (datetime): The date that the entry started at.
/// - end_date (datetime): The date that the entry ended at. If not specified, it will fall back on the `start_date`.
/// - body (content): The content of the entry.
#let create_entry(
  entry_type: none, title: "", type: none, start_date: none, end_date: none, body,
) = {
  let (state, entry_label) = if entry_type == "frontmatter" {
    (globals.frontmatter_entries, label("notebook_frontmatter"))
  } else if entry_type == "body" {
    (globals.entries, label("notebook_body"))
  } else if entry_type == "appendix" {
    (globals.appendix_entries, label("notebook_appendix"))
  } else {
    panic("No valid entry type selected")
  }

  end_date = if end_date == none {
    start_date
  }

  state.update(
    entries => {
      // Inject the proper labels and settings changes into the user's entry body
      let final_body = if entries.len() == 0 {
        [#counter(page).update(1)] // Correctly set the page number for each section
      } + [ #metadata(none) #entry_label ] + body // Place a label on blank content to the table of contents can find each entry

      entries.push(
        (
          context: (title: title, type: type, start_date: start_date, end_date: end_date), body: final_body,
        ),
      )
      entries
    },
  )
}

/// Variant of the `#create_entry()` function that creates a frontmatter entry.
#let create_frontmatter_entry = create_entry.with(entry_type: "frontmatter")

/// Variant of the `#create_entry()` function that creates a body entry.
#let create_body_entry = create_entry.with(entry_type: "body")

/// Variant of the `#create_entry()` function that creates an appendix entry.
#let create_appendix_entry = create_entry.with(entry_type: "appendix")
