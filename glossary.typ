#import "./globals.typ"

/// Add a term to the glossary
/// - word (string): The word you're defining
/// - definition (string): The definition of the word
#let add-term(word, definition) = {
  globals.glossary-entries.update(entries => {
    entries.push((word: word, definition: definition))
    entries
  })
}
