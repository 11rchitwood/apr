# Copilot Instructions

## Version Control

1. **Commit Often**: Make small, frequent commits with clear messages. Use the present tense, imperative mood ("Add feature" not " I added feature").
2. **Branching**: Use branches for new features or bug fixes. Merge back to the main branch when complete.
3. **Pull Requests**: Use pull requests for code reviews and discussions before merging changes.

## Error Handling

Prefer using `stopifnot()` for error handling where applicable.

```r
# Good
stopifnot(length(x) == prod(value))

# Bad
if (length(x) != prod(value)) {
  stop("New dimensions must match the number of elements in x")
}
```

## Test-Driven Development

Use Test-Driven Development (TDD) when developing a new feature.

1. Write a test for the new feature and watch it fail (red).
2. Write the minimum amount of code necessary to make the test pass (green).
3. Clean the code while keeping the test green (refactor).

Repeat the process for any new features or changes.

## Code Review

When suggesting changes during code review, use TDD as well. That is, make the suggested change explicit by writing a failing test. Then, follow the TDD process to make the test pass and refactor the code as needed.
