#import "./globals.typ"
#import "./themes/themes.typ"
#import "/utils.typ"

#let fallback-to-default(key, theme) = {
  let component = theme.at(key, default: none)
  if component == none {
    return themes.default.default-theme.at(key)
  } else {
    return component
  }
}

/// Internal function used by the template to print out the cover
///
/// - theme (theme):
/// - ctx (dictionary):
/// -> content
#let print-cover(theme: (:), ctx: (:)) = {
  let cover-func = fallback-to-default("cover", theme)
  cover-func(ctx: ctx)
}

/// Internal function used by the template to print out all of the entries
///
/// - theme (theme):
/// -> content
#let print-entries(theme: (:)) = {
  let print-helper(section, state) = {
    locate(loc => {
      for (index, entry) in utils.sort_entries(state.final(loc)).enumerate() [
        #let entry-func = fallback-to-default(section + "-entry", theme)
        #let body = if index == 0 [#counter(page).update(1)] else [] + entry.body
        #entry-func(body, ctx: entry.ctx)
      ]
    })
  }

  print-helper("frontmatter", globals.frontmatter-entries)
  print-helper("body", globals.entries)
  print-helper("appendix", globals.appendix-entries)
}
