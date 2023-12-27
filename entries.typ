#import "/globals.typ"
#import "./utils.typ"
#import "./themes/themes.typ"

/// Generic entry creation function
///
/// - entry_type (string): The type of entry. Takes either "frontmatter", "body", or "appendix"
/// - title (string): The title of the entry
/// - type (string): The type of entry. The possible values for this are decided by the theme.
#let push_entry(
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

#let fallback_to_default(key, theme) = {
  let component = theme.at(key, default: none)
  if component == none {
    return themes.default.default_theme.at(key)
  } else {
    return component
  }
}

#let create_frontmatter_entry = push_entry.with(entry_type: "frontmatter")
#let create_entry = push_entry.with(entry_type: "body")
#let create_appendix_entry = push_entry.with(entry_type: "appendix")

/// Internal function used by the template to print out the cover
///
/// - theme (dictionary):
/// - context (dictionary):
/// -> content
#let print_cover(theme: (:), context: (:)) = {
  let cover_func = fallback_to_default("cover", theme)
  cover_func(context: context)
}

/// Internal function used by the template to print out all of the entries
///
/// - theme (dictionary):
/// -> content
#let print_entries(theme: (:)) = {
  let print_helper(section, state) = {
    locate(loc => {
      for entry in state.final(loc) [
        #let entry_func = fallback_to_default(section + "_entry", theme)
        #let body = [] + entry.body
        #entry_func(body, context: entry.context)
      ]
    })
  }

  print_helper("frontmatter", globals.frontmatter_entries)
  print_helper("body", globals.entries)
  print_helper("appendix", globals.appendix_entries)
}
