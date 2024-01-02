#import "/utils.typ"

/// Print out the glossary
///
/// Example Usage:
///
/// ```typ
/// #create_frontmatter_entry(title: "Glossary")[
///   #components.glossary()
/// ]
/// ```
#let glossary() = {
  columns(2)[
    #utils.print_glossary(entry => [
      == #entry.word
      #entry.definition
    ])
  ]
}
