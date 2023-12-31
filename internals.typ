#let fallback_to_default(key, theme) = {
  let component = theme.at(key, default: none)
  if component == none {
    return themes.default.default_theme.at(key)
  } else {
    return component
  }
}

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
