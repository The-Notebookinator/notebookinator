#import "/globals.typ"
#import "./utils.typ"
#import "./themes/themes.typ"

/// The generic entry creation function. This function is not meant to be called by the user. Instead, use the three entry variants, frontmatter, body, and appendix, to create entries.
///
/// - section (string): The type of entry. Takes either "frontmatter", "body", or "appendix".
/// - title (string): The title of the entry.
/// - type (string): The type of entry. The possible values for this are decided by the theme.
/// - date (datetime): The date that the entry occured at.
/// - body (content): The content of the entry.
#let create-entry(
  section: none,
  title: "",
  type: none,
  date: none,
  author: "",
  witness: "",
  body,
) = {
  let (state, entry-type) = if section == "frontmatter" {
    (globals.frontmatter-entries, "notebook-frontmatter")
  } else if section == "body" {
    (globals.entries, "notebook-body")
  } else if section == "appendix" {
    (globals.appendix-entries, "notebook-appendix")
  } else {
    panic("No valid entry type selected")
  }

  state.update(
    entries => {
      // let unique-label = label(entry-type + ":" + str(entries.len()))
      let entry-type-label = label(entry-type)
      // Inject the proper labels and settings changes into the user's entry body
      let final-body = [
        #metadata(none) #entry-type-label 
        #counter(footnote).update(0)
      ] + body // Place a label on blank content to the table of contents can find each entry

      entries.push(
        (
          ctx: (title: title, type: type, date: date, author: author, witness: witness),
          body: final-body,
        ),
      )
      entries
    },
  )
}

/// Variant of the `#create-entry()` function that creates a frontmatter entry.
///
/// *Example Usage:*
///
/// ```typ
/// #create-frontmatter-entry(title: "Frontmatter")[
///   #lorem(50)
/// ]
/// ```
///
#let create-frontmatter-entry = create-entry.with(section: "frontmatter")

/// Variant of the `#create-entry()` function that creates a body entry.
///
/// *Example Usage:*
///
/// ```typ
/// #create-body-entry(
///   title: "Title",
///   date: datetime(year: 2024, month: 1, day: 1),
///   type: "identify", // Change this depending on what your theme allows
///   author: "Bobert",
///   witness: "Bobernius",
/// )[
///   #lorem(50)
/// ]
/// ```
#let create-body-entry = create-entry.with(section: "body")

/// Variant of the `#create-entry()` function that creates an appendix entry.
///
/// *Example Usage:*
///
/// ```typ
/// #create-appendix-entry(title: "Appendix")[
///   #lorem(50)
/// ]
/// ```
#let create-appendix-entry = create-entry.with(section: "appendix")
