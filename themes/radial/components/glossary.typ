#import "/utils.typ"

/// Print out the glossary
/// -> content
#let glossary() = {
  columns(2)[
    #utils.print_glossary(entry => [
      == #entry.word
      #entry.definition
    ])
  ]
}
