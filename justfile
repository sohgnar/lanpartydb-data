_default:
    @just --list

fetch-contributors:
    @python3 tools/fetch_contributors.py > data/contributors.json

validate: && validate-series validate-parties validate-party-dates

validate-series:
    @echo "Validating series ..."
    @taplo lint --schema "file://"$PWD"/schemas/series.json" data/series.toml && taplo format --check data/series.toml

validate-parties:
    @echo "Validating parties ..."
    @taplo lint --schema "file://"$PWD"/schemas/party.json" data/parties/**/*.toml && taplo format --check data/parties/**/*.toml

validate-party-dates:
    @echo "Validating party dates ..."
    @python3 tools/check_party_date.py data/parties/**/*.toml
