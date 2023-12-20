#import "/globals.typ": *
#import "./themes/themes.typ"

#let push_entry(
  title: "", type: none, start_date: none, end_date: none, state: none, body,
) = {
  state.update(
    x => {
      x.push(
        (
          context: (
            title: title,
            type: type,
            start_date: start_date,
            end_date: end_date,
          ),
          body: body,
        ),
      )
      x
    },
  )
}

#let create_frontmatter_entry = push_entry.with(state: frontmatter_entries)
#let create_entry = push_entry.with(state: entries)
#let create_appendix_entry = push_entry.with(state: appendix_entries)

/// This function returns the final rendered content of every single entry, front matter and appendix included, with the selected theme applied.
#let print_entries(theme: (:)) = {
  let fallback_default(key, theme) = {
    let component = theme.at(key, default: none)
    if component == none {
      return themes.default.default_theme.at(key)
    } else {
      return component
    }
  }

  let print_helper(section, state) = {
    locate(
      loc => {
        for entry in state.final(loc) [
          #let entry_func = fallback_default(section + "_entry", theme)
          #entry_func(entry.body, context: entry.context)
          #label("nb_" + section)
        ]
      },
    )
  }

  print_helper("frontmatter", frontmatter_entries)
  print_helper("body", entries)
  print_helper("appendix", appendix_entries)
}
