#import "../colors.typ": *

#import "@preview/cetz:0.1.2"

/// Creates a labeled pie chart.
///
/// Example Usage:
///
/// ```typ
/// #pie-chart(
///   (value: 8, color: green, name: "wins"),
///   (value: 2, color:  red, name: "losses")
/// )
/// ```
///
/// - ..data (dictionary): Each dictionary must contain 3 fields.
///   - value: `<integer>` The value of the section
///   - color: `<color>` The value of the section
///   - name: `<string>` The name of the section
/// -> content
#let pie-chart(..data) = {
  let total;
  let percentages = ();

  for value in data.pos() {
    total += value.value;
  }

  for value in data.pos() {
    percentages.push(calc.round(value.value / total * 100))
  }

  cetz.canvas(
    {
      import cetz.draw: *

      let chart(..values, name: none) = {
        let values = values.pos()
        let anchor-angles = ()

        let offset = 0
        let total = values.fold(0, (s, v) => s + v.value)

        let segment(from, to) = {
          merge-path(close: true, {
            stroke((paint: black, join: "round", thickness: 0pt))
            line((0, 0), (rel: (360deg * from, 2)))
            arc((), start: from * 360deg, stop: to * 360deg, radius: 2)
          })
        }

        let chart = group(name: name, {
          stroke((paint: black, join: "round"))

          for v in values {
            fill(v.color)
            let value = v.value / total

            // Draw the segment
            segment(offset, offset + value)

            // Place an anchor for each segment
            let angle = offset * 360deg + value * 180deg
            anchor(v.name, (angle, 1.75))
            anchor-angles.push(angle)

            offset += value
          }
        })

        return (chart, anchor-angles)
      }

      // Draw the chart
      let (chart, angles) = chart(..data, name: "chart")

      chart

      set-style(mark: (fill: white, start: "o", stroke: black), content: (padding: .1))
      for (index, value) in data.pos().enumerate() {
        let anchor = "chart." + value.name
        let angle = angles.at(index)

        let (line-end, anchor-direction) = if angle > 90deg and angle < 275deg {
          ((-0.5, 0), "right")
        } else {
          ((0.5, 0), "left")
        }

        line(anchor, (to: anchor, rel: (angle, 0.5)), (rel: line-end))

        content((), [#value.name], anchor: "bottom-" + anchor-direction)
        content((), [ #percentages.at(index)% ], anchor: "top-" + anchor-direction)
      }
    },
  )
}
