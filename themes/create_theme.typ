#import "/globals.typ": *

#let create_theme(
  name: none,
  components: (
    // Arbitrary set and show rules
    rules: none,

    // Misc
    cover: none,
    title: none,
    heading: none,
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
) = {
  themes.update(x => {
    x.push(
      name: components
    )
  })
}
