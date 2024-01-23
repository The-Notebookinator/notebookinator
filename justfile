package target:
  ./scripts/package "{{target}}"

install target="@local":
  ./scripts/package "{{target}}"

test *filter:
  ./scripts/test test {{filter}}

docs:
  typst compile docs.typ docs.pdf
