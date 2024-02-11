gallery_dir := "./gallery"

package target:
  ./scripts/package "{{target}}"

install:
  ./scripts/package "@local"

docs:
  typst compile docs.typ docs.pdf

gallery:
  for f in "{{gallery_dir}}"/*.typ; do typst c "$f" --format png "${f/.typ}{n}.png" --root ./; done
