# pre-commit-perl
perl hooks for https://pre-commit.com/

## Using these hooks

Add this to your `.pre-commit-config.yaml`

    - repo: https://github.com/henryykt/pre-commit-perl
      rev: v0.0.4
      hooks:
        - id: perlcritic
        - id: perltidy

## Available hooks

- `perlcritic` - Runs `perlcritic --stern --verbose 8`. Settings can be overridden by
.perlcriticrc.
- `perltidy` - Runs `perltidy -pbp -nst -w -b`. Settings can be overridden by
.perltidyrc.

### Using a minimum version of `perltidy`

Pass `--min-version` as an argument for the perltidy hook.

    - repo: https://github.com/henryykt/pre-commit-perl
      rev: v0.0.4
      hooks:
        - id: perlcritic
        - id: perltidy
          args: [--min-version=20190601]
