#let check-type(
  ctx,
  field,
  expected-type,
) = {
  let given-type = type(
    ctx.at(field),
  )
  assert.eq(
    given-type,
    expected-type,
    message: "Expected " + field + " to be of type " + str(expected-type) + ", but got: " + given-type,
  )
}

#let check-multiple-types(
  ctx,
  fields,
  expected-type,
) = {
  for field in fields {
    check-type(
      ctx,
      field,
      expected-type,
    )
  }
}

#let make-theme(
  rules: none,
  cover: none,
  frontmatter-entry: none,
  body-entry: none,
  appendix-entry: none,
) = {
  // TODO: sub in default theme functions if not present
  return (
    rules: rules,
    cover: cover,
    frontmatter-entry: frontmatter-entry,
    body-entry: body-entry,
    appendix-entry: appendix-entry,
  )
}

#let make-cover(
  callback,
) = {
  return (
    ctx: (:),
  ) => {
    check-multiple-types(
      ctx,
      (
        "team-name",
        "season",
        "year",
      ),
      str,
    )

    callback(ctx)
  }
}

#let make-frontmatter-entry(
  callback,
) = {
  assert.eq(
    type(callback),
    function,
  )

  return (
    ctx: (:),
    body,
  ) => {
    check-type(
      ctx,
      "title",
      str,
    )
    callback(
      ctx,
      body,
    )
  }
}

#let make-body-entry(
  callback,
) = {
  assert.eq(
    type(callback),
    function,
  )

  return (
    ctx: (:),
    body,
  ) => {
    let valid-entry-types = (
      "identify",
      "brainstorm",
      "decide",
      "build",
      "program",
      "test",
      "management",
      "notebook",
    )

    let valid-types-printable = valid-entry-types.fold(
      "",
      (
        base,
        value,
      ) => {
        base + " '" + value + "'"
      },
    )

    // @typstyle off
    check-type(ctx, "title", str)

    // @typstyle off
    check-type(ctx, "type", str)

    // @typstyle off
    check-type(ctx, "date", datetime)

    // @typstyle off
    check-type(ctx, "author", str)

    // @typstyle off
    check-type(ctx, "witness", str)



    if not valid-entry-types.contains(ctx.type) {
      panic("Entry type '" + str(ctx.type) + "' Valid types include:" + valid-types-printable)
    }

    callback(
      ctx,
      body,
    )
  }
}

// All of the check logic is exactly the same, so we can just use the frontmater-entry here
#let make-appendix-entry = make-frontmatter-entry
