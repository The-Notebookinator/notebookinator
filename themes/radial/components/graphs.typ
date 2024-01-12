#import "../colors.typ": *

#import "@preview/cetz:0.1.2"

/// Creates a labeled pie chart.
///
/// Example Usage:
///
/// ```typ
/// #pie_chart(
///   (8, green, "wins"),
///   (2, red, "losses")
/// )
/// ```
///
/// - ..data (array): Each array must contain 3 fields.
///   + `<integer>` The value of the section
///   + `<color>` The value of the section
///   + `<string>` The name of the section
///   Here's an example of one of these arrays:
///   `(2, blue, "bicycles")`
/// -> content
#let pie_chart(..data) = {
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
        let anchor_angles = ()

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
            anchor_angles.push(angle)

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

#let parse_timestamp(timestamp) = {
  let data = timestamp.matches(regex("(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})"))
  let captures = data.at(0).captures

  datetime(
    year: int(captures.at(0)), month: int(captures.at(1)), day: int(captures.at(2)), hour: int(captures.at(3)), minute: int(captures.at(4)), second: int(captures.at(5)),
  )
}

///
/// Example Usage:
///
/// #plot(
///   (name: "thingy", color: red, data: ((1,2), (2,5), (3,5))),
///   (name: "stuff", color: green, data: ((1,1), (2,7), (3,6))),
///   (name: "potato", color: blue, data: ((1,1), (2,3), (3,8))),
/// )
///
/// - ..data (dictionary):
/// -> content
#let plot(
  title: "",
  x_label: "",
  y_label: "",
  ..data
  ) = {
  set align(center)
  cetz.canvas(
    length: 8.5%, {
      import cetz.draw: *
      import cetz.plot
      import cetz.palette

      plot.plot(
        name: "plot",
        style: palette.tango,
        size: (9, 6), axis-style: "left", x-grid: "both", y-grid: "both", {
        for row in data.pos() {
          plot.add(row.data, fill: true)
        }
      })

      content("plot.top", [*#title*])
      content((to: "plot.bottom", rel: (0,-0.5)), [#x_label])
      content((to: "plot.left", rel: (-0.5, 0)), [#y_label], angle: 270deg)
    },
  )
}
