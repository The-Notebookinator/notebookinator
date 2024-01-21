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
#let glossary() = utils.print-glossary(glossary => {
  columns(2)[
    #for entry in glossary {
      box[
        == #entry.word
        #entry.definition
        \
      ]
    }
  ]
})
