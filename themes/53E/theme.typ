#let heading(level, body) = {
  if level == 1 [
    #body
  ] else if level == 2 [
    #body
  ]
}

#create_theme(
  name: "53E",
  components: (
    rules: {}

    // Misc
    cover: none,
    title: none,
    heading: heading,
    toc: none,
    glossary: none,

    // Entries
    frontmatter_title: none,
    frontmatter_footer: none,

    entry_title: none,
    entry_footer: none,

    appendix_title: none,
    appendix_footer: none,

    // User called components
    admonition: none,
    matrix: none,
    pro_con: none,

    // Plots
    pie_chart: none,
    plot: none,
  )
)
