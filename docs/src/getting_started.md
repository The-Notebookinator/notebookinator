# Basic Usage

Once you have the Notebookinator installed, we recommend you use our [official template](https://github.com/The-Notebookinator/quick-start-template) to bootstrap your project.

```typ
#import "@local/notebookinator:1.0.1": *
```

Once you've done that you can begin to write your notebook:

```typ
#import themes.default: default-theme, components

#show: notebook.with(theme: default-theme)

#create-body-entry(title: "My Entry")[
 #lorem(200)
]
```

You can then compile your notebook with the Typst CLI:

```bash
typst compile your-notebook-file.typ
```
