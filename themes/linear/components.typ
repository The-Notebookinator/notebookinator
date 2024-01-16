#import "/utils.typ"

#let toc() = {
  utils.print_toc(context => [
    #context.title
    #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
    #context.page_number
  ])

  utils.print_toc(type: "appendix", context => [
    #context.title
    #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
    #context.page_number
  ])
}
