#import "/globals.typ"
#import "./utils.typ"
#import "./themes/themes.typ"

/// Generic entry creation function.
///
/// - entry-type (string): The type of entry. Takes either "frontmatter", "body", or "appendix".
/// - title (string): The title of the entry.
/// - type (string): The type of entry. The possible values for this are decided by the theme.
/// - start-date (datetime): The date that the entry started at.
/// - end-date (datetime): The date that the entry ended at. If not specified, it will fall back on the `start-date`.
/// - body (content): The content of the entry.
#let create-entry(
  entry-type: none, title: "", type: none, start-date: none, end-date: none, body,
) = {
  let (state, entry-label) = if entry-type == "frontmatter" {
    (globals.frontmatter-entries, label("notebook-frontmatter"))
  } else if entry-type == "body" {
    (globals.entries, label("notebook-body"))
  } else if entry-type == "appendix" {
    (globals.appendix-entries, label("notebook-appendix"))
  } else {
    panic("No valid entry type selected")
  }

  end-date = if end-date == none {
    start-date
  }

  state.update(
    entries => {
      // Inject the proper labels and settings changes into the user's entry body
      let final-body = if entries.len() == 0 {
        [#counter(page).update(1)] // Correctly set the page number for each section
      } + [ #metadata(none) #entry-label ] + body // Place a label on blank content to the table of contents can find each entry

      entries.push(
        (
          context: (title: title, type: type, start-date: start-date, end-date: end-date), body: final-body,
        ),
      )
      entries
    },
  )
}

/// Variant of the `#create-entry()` function that creates a frontmatter entry.
#let create-frontmatter-entry = create-entry.with(entry-type: "frontmatter")

/// Variant of the `#create-entry()` function that creates a body entry.
#let create-body-entry = create-entry.with(entry-type: "body")

/// Variant of the `#create-entry()` function that creates an appendix entry.
#let create-appendix-entry = create-entry.with(entry-type: "appendix")
