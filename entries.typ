#import "/globals.typ"
#import "./utils.typ"
#import "./themes/themes.typ"

/// Generic entry creation function.
///
/// - section (string): The type of entry. Takes either "frontmatter", "body", or "appendix".
/// - title (string): The title of the entry.
/// - type (string): The type of entry. The possible values for this are decided by the theme.
/// - date (datetime): The date that the entry occured at.
/// - body (content): The content of the entry.
#let create-entry(section: none, title: "", type: none, date: none, body) = {
  let (state, entry-label) = if section == "frontmatter" {
    (globals.frontmatter-entries, label("notebook-frontmatter"))
  } else if section == "body" {
    (globals.entries, label("notebook-body"))
  } else if section == "appendix" {
    (globals.appendix-entries, label("notebook-appendix"))
  } else {
    panic("No valid entry type selected")
  }

  state.update(
    entries => {
      // Inject the proper labels and settings changes into the user's entry body
      let final-body = if entries.len() == 0 {
        [#counter(page).update(1)] // Correctly set the page number for each section
      } + [ #metadata(none) #entry-label ] + body // Place a label on blank content to the table of contents can find each entry

      entries.push((context: (title: title, type: type, date: date), body: final-body))
      entries
    },
  )
}

/// Variant of the `#create-entry()` function that creates a frontmatter entry.
#let create-frontmatter-entry = create-entry.with(section: "frontmatter")

/// Variant of the `#create-entry()` function that creates a body entry.
#let create-body-entry = create-entry.with(section: "body")

/// Variant of the `#create-entry()` function that creates an appendix entry.
#let create-appendix-entry = create-entry.with(section: "appendix")
