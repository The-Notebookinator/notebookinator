#import "./appendix.typ": *
#import "./entries.typ": *
#import "./frontmatter.typ": *


/// The entry point for the notebook
#let notebook(
  team_name: "",
  season: "",
  theme: "default",
  body
) = {
  set text(fill: red)
  body
}
