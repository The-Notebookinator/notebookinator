package target:
  ./scripts/package "{{target}}"

install:
  ./scripts/package "@local"

docs:
  typst compile docs.typ docs.pdf
