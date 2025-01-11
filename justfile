_default:
    @just --list

validate:
    @just validate-series
    @just validate-parties
    @just validate-party-dates

validate-series:
    @taplo lint --schema "file://"$PWD"/schemas/series.json" data/series.toml && taplo format --check data/series.toml

validate-parties:
    @taplo lint --schema "file://"$PWD"/schemas/party.json" data/parties/**/*.toml && taplo format --check data/parties/**/*.toml

validate-party-dates:
    @python3 tools/check_party_date.py data/parties/**/*.toml
