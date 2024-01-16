#import "/utils.typ"

/// Print out the glossary
///
/// Example Usage:
///
/// ```typ
/// #create-frontmatter-entry(title: "Glossary")[
///   #components.glossary()
/// ]
/// ```
#let glossary() = {
  columns(2)[
    #utils.print-glossary(entry => [
      == #entry.word
      #entry.definition
    ])
  ]
}
