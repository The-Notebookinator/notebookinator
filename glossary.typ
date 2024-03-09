#import "./globals.typ"

/// Adds a term and definition to the glossary
/// 
/// *Example Usage*
/// ```typ
/// #glossary.add-term("Term")[
///   Definition
/// ]
/// ```
/// - word (string): The word you're defining
/// - definition (string): The definition of the word
#let add-term(word, definition) = {
  globals.glossary-entries.update(entries => {
    entries.push((word: word, definition: definition))
    entries
  })
}
