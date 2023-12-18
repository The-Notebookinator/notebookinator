/// A utility function to help themes implement a table of contents
///
/// - row_callback (function): A function that returns content
#let print_toc(
  row_callback: none
) = {
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

/// A utility function to help themes implement decision matrices.
/// 
/// - properties (array): The properties to rate each choice by
/// - ..choices (array): The choices that can be chosen
#let calc_decision_matrix(
  properties: (),
  ..choices,
) = {

}
