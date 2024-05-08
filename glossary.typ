#import "./globals.typ"

/// Adds a term to the glossary.
///
/// *Example Usage:*
///
/// ```typ
/// #glossary.add-term(
///   "Word",
///   "The definiton of the word."
/// )
/// ```
///
/// - word (string): The word you're defining
/// - definition (string): The definition of the word
///
#let add-term(word, definition) = {
  globals.glossary-entries.update(entries => {
    entries.push((word: word, definition: definition))
    entries
  })
}
