#import "../colors.typ": *
#import "../icons/icons.typ": *
#import "@preview/timeliney:0.0.1"

/// Creates a gantt chart for task management.
///
/// Example Usage:
///
/// ```typ
/// #gantt_chart(
///   months: (
///     (month: [January], length: 4),
///     (month: [February], length: 4),
///   ),
///   dates: (
///     (date : [Week 1], length: 1),
///     (date : [Week 2], length: 1),
///     (date : [Week 3], length: 1),
///     (date : [Week 4], length: 1),
///     (date : [Week 1], length: 1),
///     (date : [Week 2], length: 1),
///     (date : [Week 3], length: 1),
///     (date : [Week 4], length: 1),
///   ),
///   tasks: (
///     (
///       task: [Build Robot],
///       time: (0,3),
///       color: blue
///     ),
///     (
///       task: [Drive Robot],
///       time: (3,7),
///       color: green
///     ),
///     (
///       task: [Code Robot],
///       time: (2,6),
///       color: yellow
///     ),
///     (
///       task: [Destroy Robot],
///       time: (7,8),
///       color: red
///     ),
///   ),
///   goals: (
///     (
///       goal: [*Tournament*],
///       position: 7
///     ),
///   )
/// )
/// ```
/// - months (dictionary): This is an optional parameter, but can be used in conjunction with dates for two header lines
/// - month: `<content>`
/// - length: `<integer>` 
/// - dates (dictionary): Creates a headerline under the months headerline, and is used to put the days for the chart.
/// - date: `<content>`
/// - length: `<integer>` 
/// - tasks (dictionary): Creates the actual lines on the chart.
/// - task: `<content>`
/// - length: `<array>`
///   - (`<float>` or `<integer>`, `<float>` or `<integer>`) 
/// - color: `<color>`
/// - goals (dictionary): Used to create milestones along the timeline
/// - goal: `<content>`
/// - position: `<float>` or `<integer>`
/// -> content
#let gantt_chart(
  start: datetime,
  end: datetime,
  date-intervals: [],
  date-format: [],
  tasks: (([], (0,0)),),
  goals: (([], 0)),
) = {
  timeliney.timeline(
    spacing: 5pt,
    
    show-grid: true,
    grid-style: (stroke: (dash: "dashed", thickness: .5pt, paint: gray)),

    tasks-vline: true,
    line-style: (stroke: 0pt),

    milestone-overhang: 1pt,
    milestone-layout: "in-place",
    box-milestones: true,
    milestone-line-style: (stroke: (dash: "dashed", thickness: 1pt, paint: black)),
    {
      import timeliney: *

      let difference = end - start

      if ((start.month() != end.month()) or (start.year() != end.year()))  {
        let months = ()
        let next
        let total

        if start.month() == 12 {
          total = end.month()
          next = datetime(year: start.year() + 1, month: 1, day: 1) - start
        } else {
          total = calc.abs(start.month() - end.month())
          next = datetime(year: start.year(), month: start.month() + 1, day: 1) - start
        }
        months.push(group(((start.display("[month repr:long]")),int(next.days()))))
        for value in range(total) {
          // WIP
        }
        headerline(..months)
      } else {
        headerline(group(((start.display("[month repr:long]")),int(difference.days()+1))))
      }

      let dates_array = ()

      for value in range(int(difference.days()) + 1) {
        dates_array.push(group(((start + duration(days: value)).display(),1)))
      }
      headerline(..dates_array)

      let colors = (red, orange, yellow, green, blue, violet)
      let index = 0
      
      taskgroup({
        for item in tasks {

          if item.len() == 2 {
            if index > colors.len() {
              index = 0
            }
            task(item.at(0), item.at(1), style: (stroke: (paint: colors.at(index), thickness: 5pt, cap: "butt")))
            index += 1
          } else {
            task(item.at(0), item.at(1), style: (stroke: (paint: item.at(2), thickness: 5pt, cap: "butt")))
          }
        }
      })
    }
  )
}

#gantt_chart(
  start: datetime(
    year: 2024,
    month: 11,
    day: 30,
  ),
  end: datetime(
    year: 2024,
    month: 12,
    day: 4,
  ),
  tasks: (
    ("Balls", (0,1)),
    ("Tall", (0,1)),
  )
)

#let gantt_chart(
  months: ((
    month: [],
    length: 1
    ),
  ),
  dates: ((
    date: [],
    length: 1
    ),
  ),
  tasks: ((
    task: [],
    time: (0,1),
    color: none
    ),
  ),
  goals: ((
    goal: [],
    position: 0
  ))
) = {
  timeliney.timeline(
    spacing: 5pt,
    
    show-grid: true,
    grid-style: (stroke: (dash: "dashed", thickness: .5pt, paint: gray)),

    tasks-vline: true,
    line-style: (stroke: 0pt),

    milestone-overhang: 1pt,
    milestone-layout: "in-place",
    box-milestones: true,
    milestone-line-style: (stroke: (dash: "dashed", thickness: 1pt, paint: black)),
    {
      import timeliney: *

      if months.at(0).month != "" {
        let months_array = ()
        for month in months{
          months_array.push(group((month.month, month.length)))
        }
        headerline(..months_array)
      }

      let dates_array = ()
      for date in dates{
        dates_array.push(group((date.date, date.length)))
      }
      headerline(..dates_array)

      if goals.at(0).position != [] {
        for goal in goals {
          milestone(goal.goal, at: goal.position)
        }
      }

      let colors = (red, orange, yellow, green, blue, violet)
      let index = 0
      let pos = ()

      taskgroup({
        for item in tasks {
          pos = (item.time.at(0)+0.06, item.time.at(1)-0.06)
          if item.color != none {
            task(item.task, pos, style: (stroke: (paint: item.color, thickness: 5pt, cap: "round")))
          } else {
            task(item.task, pos, style: (stroke: (paint: colors.at(index), thickness: 5pt, cap: "round")))
            index += 1
            if index > colors.len() {
              index = 0
            }
          }
        }
      })
    }
  )
}

   #gantt_chart(
   months: (
     (month: [January], length: 4),
     (month: [February], length: 4),
   ),
   dates: (
     (date : [Week 1], length: 1),
     (date : [Week 2], length: 1),
     (date : [Week 3], length: 1),
     (date : [Week 4], length: 1),
     (date : [Week 1], length: 1),
     (date : [Week 2], length: 1),
     (date : [Week 3], length: 1),
     (date : [Week 4], length: 1),
   ),
   tasks: (
     (
       task: [Build Robot],
       time: (0,3),
       color: none
     ),
     (
       task: [Drive Robot],
       time: (3,7),
       color: none
     ),
     (
       task: [Code Robot],
       time: (2,6),
       color: none
     ),
     (
       task: [Destroy Robot],
       time: (7,8),
       color: none
     ),
   ),
   goals: (
     (
       goal: [*Tournament*],
       position: 7
     ),
   )
 )
 