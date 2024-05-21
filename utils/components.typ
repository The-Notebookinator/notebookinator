#import "/globals.typ"

/// Example Usage:
/// ```typ
/// #let toc = utils.make-toc((frontmatter, body, appendix) => {
///   for entry in body [
///     #entry.title
///     #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
///     #entry.page-number
///   ]
/// })
/// ```
/// - callback (function): A function which takes the #link(<ctx>)[ctx] of all entries as input, and returns the content of the entire table of contents.
/// -> content
#let make-toc(
  callback,
) = {
  let helper(
    type,
  ) = {
    let (
      state,
      markers,
    ) = if type == "frontmatter" {
      (
        globals.frontmatter-entries,
        query(
          selector(<notebook-frontmatter>),
        ),
      )
    } else if type == "body" {
      (
        globals.entries,
        query(
          selector(<notebook-body>),
        ),
      )
    } else if type == "appendix" {
      (
        globals.appendix-entries,
        query(
          selector(<notebook-appendix>),
        ),
      )
    } else {
      panic("No valid entry type selected.")
    }

    let result = ()

    for (
      index,
      entry,
    ) in state.final().enumerate() {
      let page-number = counter(page).at(
        markers.at(index).location(),
      ).at(0)
      let ctx = entry.ctx
      ctx.page-number = page-number
      result.push(ctx)
    }
    return result
  }


  return () => context {
    let frontmatter-entries = helper("frontmatter")
    let body-entries = helper("body")
    let appendix-entries = helper("appendix")

    callback(
      frontmatter-entries,
      body-entries,
      appendix-entries,
    )
  }
}

// Glossary
// Pro / Con
// Decision Matrix
