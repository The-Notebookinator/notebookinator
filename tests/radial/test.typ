#import "/lib.typ": *

#import themes.radial: radial-theme, components

#show: notebook.with(theme: radial-theme)

#create-frontmatter-entry(title: "Table Of Contents")[
  #components.toc()
]

#create-body-entry(
  title: "Table Of Contents", start-date: datetime(year: 2024, month: 1, day: 1),
  type: "decide"
)[
  #lorem(20)
]
