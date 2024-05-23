#import "/globals.typ"

/// A constructor for a table of contents component.
///
/// Example Usage:
/// ```typ
/// #let toc = utils.make-toc((frontmatter, body, appendix) => {
///   for entry in body [
///     #entry.title
///     #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
///     #entry.page-number
///   ]
/// })
/// ```
/// - callback (function): A function which returns the content of the toc
/// -> function
#let make-toc(callback) = {
  let helper(type) = {
    let (state, markers) = if type == "frontmatter" {
      (
        globals.frontmatter-entries,
        query(
          selector(<notebook-frontmatter>),
        ),
      )
    } else if type == "body" {
      (
        globals.entries,
        query(
          selector(<notebook-body>),
        ),
      )
    } else if type == "appendix" {
      (
        globals.appendix-entries,
        query(
          selector(<notebook-appendix>),
        ),
      )
    } else {
      panic("No valid entry type selected.")
    }

    let result = ()

    for (index, entry) in state.final().enumerate() {
      let page-number = counter(page).at(
        markers.at(index).location(),
      ).at(0)
      let ctx = entry.ctx
      ctx.page-number = page-number
      result.push(ctx)
    }
    return result
  }

  return () => context {
    let frontmatter-entries = helper("frontmatter")
    let body-entries = helper("body")
    let appendix-entries = helper("appendix")

    callback(
      frontmatter-entries,
      body-entries,
      appendix-entries,
    )
  }
}

/// Constructor for a glossary component
/// - callback (function): A function that returns the content of the glossary
/// -> function
#let make-glossary(callback) = {
  return () => context {
    let sorted-glossary = globals.glossary-entries.final().sorted(key: (
      (word: word, definition: definition),
    ) => word)
    callback(sorted-glossary)
  }
}

/// Constructor for a pro / con component
/// - callback (function): A function that returns the content of the pro / con table
/// -> function
#let make-pro-con(callback) = {
  return (pros: [], cons: []) => {
    callback(pros, cons)
  }
}

/// Constructor for a decision matrix
/// - callback (function): A function that returns the content of the matrix
/// -> function
#let make-decision-matrix(callback) = {
  return (properties: (), ..choices) => {
    // ensure the properties are passed in correctly
    let alternate-format = false
    for property in properties {
      if type(property) == str {
        alternate-format = true
      } else {
        assert(
          not alternate-format,
          message: "Property should be of type 'str'",
        )

        if property.at("weight", default: none) == none {
          property.insert("weight", 1)
        }

        assert.eq(type(property.name), str)
        assert(type(property.weight) == float or type(property.weight) == int)
      }
    }

    // ensure the choices are passed in correctly
    for choice in choices.pos() {
      for (index, rating) in choice.enumerate() {
        if index == 0 {
          assert.eq(type(rating), str)
          continue
        }

        assert(
          type(rating) == int or type(rating) == float,
          message: "Values for decision matrices must be of type 'float' or 'int'",
        )
      }

      assert.eq(
        choice.len() - 1,
        properties.len(),
        message: "The number of supplied values did not match the number of properties.",
      )
    }

    // the calculation should only need to parse data in one format,
    // so if the user passed in the alternate, format we'll just convert it to the standard one
    properties = if alternate-format {
      properties.map(property => (name: property, weight: 1))
    } else {
      properties
    }

    // now we can actually calculate the data
    let data = (:)

    for (index, choice) in choices.pos().enumerate() {
      let name = choice.at(0)

      let values = choice.slice(1)
      let unweighted-total = values.sum()

      let weighted-values = values.enumerate().map((
        (index, value),
      ) => value * properties.at(index).at(
        "weight",
        default: 1,
      ))
      let weighted-total = weighted-values.sum()

      let property-data = (:)

      for (index, property) in properties.enumerate() {
        property-data.insert(
          property.name,
          (
            unweighted: values.at(index),
            weighted: weighted-values.at(index),
            highest: false,
          ),
        )
      }

      property-data.insert(
        "total",
        (
          unweighted: unweighted-total,
          weighted: weighted-total,
          highest: false,
        ),
      )

      data.insert(
        name,
        property-data,
      )
    }

    // now that we've filled in all of the data, we can calculate which choice won

    // we're going to treat total like another property for the sake of calculating if it won
    properties.push((name: "total"))

    for property in properties {
      let highest = ( // Records the index of the choice which had the highest total
        index: 0,
        value: 0,
      )

      for (index, choice) in data {
        let property-value = choice.at(property.name).weighted
        if property-value > highest.value {
          highest.index = index
          highest.value = property-value
        }
      }
      data.at(highest.index).at(property.name).highest = true
    }
    properties.pop()


    return callback(properties, data)
  }
}

/// A constructor for an admonition component
/// - callback (function): A function that returns the content for the admonition
/// -> function
#let make-admonition(callback) = {
  let valid-types = (
    "note",
    "example",
    "warning",
    "quote",
    "equation",
    "decision",
    "build",
  )

  let valid-types-printable = valid-types.fold(
    "",
    (
      base,
      value,
    ) => {
      base + " '" + value + "'"
    },
  )

  return (type: none, body) => {
    if not valid-types.contains(type) {
      panic("Entry type '" + str(type) + "' Valid types include:" + valid-types-printable)
    }

    callback(
      type,
      body,
    )
  }
}

/// A constructor for a pie chart component
/// - callback (function): A function that returns the content for the pie chart
/// -> function
#let make-pie-chart(callback) = {
  return (..data) => {
    callback(data)
  }
}

/// A constructor for a plot component
/// - callback (function): A function that returns the content for the plot
/// -> function
#let make-plot(callback) = {
  return (title: "", x-label: "", y-label: "", length: auto, ..data) => {
    callback(title, x-label, y-label, length, data)
  }
}

// TODO: add method for these extra components:
// - plot
// - pie chart
// - admonition
// - gantt chart
// - tournament
// - team
