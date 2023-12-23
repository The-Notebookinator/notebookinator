#let print_toc() = {
  locate(
  loc => {
    let frontmatter_headings = query(selector(<nb_frontmatter>), loc)
    let body_headings = query(selector(<nb_body>), loc)
    let appendix_headings = query(selector(<nb_appendix>), loc)
    [
      #frontmatter_headings

      #body_headings
      #for (index, entry) in entries.final(loc).enumerate() {
        let page_number = counter(page).at(headings.at(index).location()).at(0)

        context => [
          #context.icon --- #context.date --- #context.title #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted"))) #page_number
        ]
      }

      #appendix_headings
    ]
  })
}

#let calc_decision_matrix() = {

}
