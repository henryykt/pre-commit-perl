# pre-commit-perl
perl hooks for https://pre-commit.com/

## Using these hooks

Add this to your `.pre-commit-config.yaml`

    - repo: github.com/henryykt/pre-commit-perl
      sha: HEAD
      hooks:
        - id: perlcritic
        - id: perltidy

## Available hooks

- `perlcritic` - Runs `perlcritic --stern --verbose 8`. Settings can be overriden by
.perlcriticrc in the repository root.
- `perltidy` - Runs `perltidy -pbp -nst -w -b`. Settings can be overridden by
.perltidyrc in the repository root.
