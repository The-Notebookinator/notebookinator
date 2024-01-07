#import "../colors.typ": *
#import "../icons/icons.typ": *
#import "@preview/timeliney:0.0.1"

#let gantt_chart(
  months: ((
    month: "",
    length: 1
    ),
  ),
  dates: ((
    date: "",
    length: 1
    ),
  ),
  tasks: ((
    task: "",
    person: "",
    time: (0,1),
    color: blue
    ),
  )
) = {
  timeliney.timeline(
    spacing: 5pt,
    show-grid: false,
    tasks-vline: true,
    line-style: (stroke: (paint: blue, thickness: 0pt, cap: "butt")),    
    {
      import timeliney: *


      if months.at(0).month != "" {
        let months_array = ()
        for m in months{
          months_array.push(group(([#m.month],m.length)))
        }
        headerline(..months_array)
      }
      
      let dates_array = ()
      for d in dates{
        dates_array.push(group(([#d.date],d.length)))
      }

      headerline(..dates_array)

      for t in tasks {
        taskgroup(title: [*#t.task*], {
          task(none, t.time, style: (stroke: (paint: t.color, thickness: 10pt, cap: "butt")))
          task(t.person, t.time, style: (stroke: 0pt))
        })
      }
    }
  )
}

#gantt_chart(
  months: (
    (month: "January", length: 4),
    (month: "February", length: 4),
  ),
  dates: (
    (date : "Week 1", length: 1),
    (date : "Week 2", length: 1),
    (date : "Week 3", length: 1),
    (date : "Week 4", length: 1),
    (date : "Week 1", length: 1),
    (date : "Week 2", length: 1),
    (date : "Week 3", length: 1),
    (date : "Week 4", length: 1),
  ),
  tasks: (
    (
      task: "Build Robot",
      person: "Jimmy ",
      time: (0,6),
      color: red
    ),
    (
      task: "Drive Robot",
      person: "Jon",
      time: (6,8),
      color: blue
    ),
  )
)