#import "./globals.typ"
// Add a term to the glossary
// - word (string): The word you're defining
// - definition (string): The definition of the word
#let add_term(word, definition) = {
  globals.glossary_entries.update(entries => {
    entries.push((word: word, definition: definition))
    entries
  })
}
