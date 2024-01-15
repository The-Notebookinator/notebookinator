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
    total += value.at(0);
  }

  for value in data.pos() {
    percentages.push(calc.round(value.at(0) / total * 100))
  }

  cetz.canvas(
    {
      import cetz.draw: *

      let chart(..values, name: none) = {
        let values = values.pos()
        let anchor-angles = ()

        let offset = 0
        let total = values.fold(0, (s, v) => s + v.at(0))

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
            fill(v.at(1))
            let value = v.at(0) / total

            // Draw the segment
            segment(offset, offset + value)

            // Place an anchor for each segment
            let angle = offset * 360deg + value * 180deg
            anchor(v.at(2), (angle, 1.75))
            anchor-angles.push(angle)

            offset += value
          }
        })

        return (chart, anchor_angles)
      }

      // Draw the chart
      let (chart, angles) = chart(..data, name: "chart")

      chart

      set-style(mark: (fill: white, start: "o", stroke: black), content: (padding: .1))
      for (index, value) in data.pos().enumerate() {
        let anchor = "chart." + value.at(2)
        let angle = angles.at(index)

        let (line_end, anchor_direction) = if angle > 90deg and angle < 275deg {
          ((-0.5, 0), "right")
        } else {
          ((0.5, 0), "left")
        }

        line(anchor, (to: anchor, rel: (angle, 0.5)), (rel: line_end))

        content((), [#value.at(2)], anchor: "bottom-" + anchor_direction)
        content((), [ #percentages.at(index)% ], anchor: "top-" + anchor_direction)
      }
    },
  )
}
