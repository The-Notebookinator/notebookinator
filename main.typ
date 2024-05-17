#import "themes/revision/revision.typ": revision-theme, components
#import "lib.typ": *

#show: notebook.with(
  theme: revision-theme
  
)

#create-frontmatter-entry(title: "About")[
    Here's some info about this amazing notebook!
]