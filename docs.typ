#import "@preview/tidy:0.1.0"

#let show-module-fn(module, fn, ..args) = {
  module.functions = module.functions.filter(f => f.name == fn)
  tidy.show-module(module, ..args.pos(), ..args.named(),
                   show-module-name: false,
                   show-outline: false)
}

#set heading(numbering: "1.")
#set terms(indent: 1em)
#show link: set text(blue)

#set page(
  numbering: "1/1",
  header: align(right)[The Notebookinator],
)

#align(center, text(16pt)[*The Notebookinator*])

#set par(justify: true)

#outline(indent: true, depth: 3)
#pagebreak(weak: true)

= Introduction

Welcome to the Notebookinator, a Typst package meant to simply the notebooking process for the Vex Robotics Competition. Its theming capabilities handle all of the styling for you, letting you jump right into writing documentation.

While it was designed with VRC in mind, it could just as easily be used for other competitor systems such as the First Robotics Competition and the First Tech Challenge.

= Installation

= Usage

= Template API Reference

#let template-module = tidy.parse-module(read("lib.typ"), name: "Template")
#tidy.show-module(template-module)

== Radial Theme

#let utils-module = tidy.parse-module(read("utils.typ"), name: "Utils")
#tidy.show-module(utils-module)

= Developer Documentation

== Project Architecture

== Implementing Your Own Theme


