#import "/globals.typ": *

// FIXME: This file is incredibly repetitive. Find some way to abstract the way entries are added to their respective global arrays.

#let create_frontmatter_entry(
  title: "",
  body
) = {
  frontmatter_entries.update(x => {
    x.push(
      (
        title: title,
        body: body
      )
    )
    x
  })
}

#let create_entry(
  title: "",
  type: none,
  start_date: none,
  end_date: none,
  body
) = {
  entries.update(x => {
    x.push(
      (
        title: title,
        type: type,
        start_date: start_date,
        end_date: end_date,
        body: body
      )
    )
    x
  })
}

#let create_appendix_entry(
  title: "",
  body
) = {
  appendix_entries.update(x => {
    x.push(
      (
        title: title,
        body: body
      )
    )
    x
  })
}

/// This function returns the final rendered content of every single entry, front matter and appendix included, with the selected theme applied.
#let print_entries(theme: (:)) = {
  let helper(section, state) = {
  locate(
  loc => {
    for entry in state.final(loc) {
        let title_func = theme.at(section + "_title")
        let footer_func = theme.at(section + "_footer")

        page(
          header: title_func(entry.title),
          footer: footer_func(entry.title),
        )[
          #entry.body
        ]
      } 
    })
  }

  helper("frontmatter", frontmatter_entries)
  helper("entry", entries)
  helper("appendix", appendix_entries)

}
