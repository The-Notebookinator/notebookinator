#let print_toc() = {
  locate(
  loc => {
    let frontmatter_headings = query(selector(<nb_frontmatter>), loc)
    let body_headings = query(selector(<nb_body>), loc)
    let appendix_headings = query(selector(<nb_appendix>), loc)
    [
      #frontmatter_headings
      #body_headings
      #appendix_headings
    ]
  })
}

#let calc_decision_matrix() = {

}
