# Pull Request

## Description

Please provide a clear and concise description of your changes.

## Type of Change

Please check the type of change your PR introduces:

- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update
- [ ] Code refactoring (no functional changes)
- [ ] Performance improvement
- [ ] Build/CI configuration
- [ ] Icon additions or updates

## Related Issues

Fixes # (issue number)
Relates to # (issue number)

## Changes Made

Please provide a detailed list of changes:

- Change 1
- Change 2
- Change 3

## Testing

Please describe the testing you've done:

- [ ] Built the solution locally without errors
- [ ] Ran the sample application and verified changes
- [ ] Tested with Blazor Server
- [ ] Tested with Blazor WebAssembly
- [ ] Tested trimming (if applicable)
- [ ] Added/updated unit tests (if applicable)
- [ ] All existing tests pass

### Test Configuration

- **.NET Version**: .NET 9.0
- **Blazor Hosting Model**: [Server / WebAssembly / Hybrid / Auto]
- **Operating System**: Windows / macOS / Linux
- **Browser(s)**: Chrome, Firefox, Safari, Edge

## Code Quality Checklist

- [ ] My code follows the code style guidelines of this project
- [ ] I have performed a self-review of my own code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] My changes generate no new warnings or errors
- [ ] I have checked that my changes don't break existing functionality
- [ ] My code respects the project's architecture (source generation, trimming, etc.)

## Documentation

- [ ] I have updated the README.md (if needed)
- [ ] I have updated the CLAUDE.md (if architecture changed)
- [ ] I have updated the CONTRIBUTING.md (if development process changed)
- [ ] I have added XML documentation comments to public APIs
- [ ] I have updated the CHANGELOG.md (if exists)

## Icon-Specific Checklist

If this PR adds or updates icons, please confirm:

- [ ] Icons are from official upstream sources (Lucide, Bootstrap, Material Design)
- [ ] Icon names follow PascalCase convention
- [ ] Icons are in the correct package directory
- [ ] Python generator script was used (not manual edits)
- [ ] Source generator successfully generated component classes
- [ ] Sample application displays new icons correctly

## Breaking Changes

If this PR introduces breaking changes, please describe:

- What breaks?
- Why is this change necessary?
- What's the migration path for existing users?

## Performance Impact

Does this change affect performance?

- [ ] No performance impact
- [ ] Performance improvement
- [ ] Potential performance regression (explain below)

## Screenshots/Videos

If applicable, add screenshots or videos to demonstrate the changes:

(Paste screenshots or video links here)

## Additional Context

Add any other context about the pull request here.

## Checklist Before Requesting Review

- [ ] I have read the [CONTRIBUTING.md](../CONTRIBUTING.md) guidelines
- [ ] My branch is up to date with the main branch
- [ ] All commits have clear, descriptive messages
- [ ] I have resolved all merge conflicts
- [ ] I am ready for this PR to be reviewed

## Post-Merge Tasks

Items to complete after merge (if applicable):

- [ ] Update NuGet package version
- [ ] Create release notes
- [ ] Update documentation website
- [ ] Announce changes (if major feature)
