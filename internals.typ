#import "./globals.typ"
#import "./themes/themes.typ"

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
      for entry in state.final(loc) [
        #let entry-func = fallback-to-default(section + "-entry", theme)
        #let body = [] + entry.body
        #entry-func(body, ctx: entry.ctx)
      ]
    })
  }

  print-helper("frontmatter", globals.frontmatter-entries)
  print-helper("body", globals.entries)
  print-helper("appendix", globals.appendix-entries)
}
