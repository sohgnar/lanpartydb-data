#!/usr/bin/env python3

"""Fetch repository contributors with avatars from GitHub.

Author: Jochen Kupperschmidt
License: MIT
"""

from collections.abc import Iterator
import json
from urllib.request import urlopen


CONTRIBUTORS_URL = 'https://api.github.com/repos/lanpartydb/data/contributors'


Contributor = dict[str, str | int]


def main() -> None:
    github_data = _fetch_contributors_from_github()
    contributors = list(_parse_contributors(github_data))
    print(_dump_as_json(contributors))


def _fetch_contributors_from_github() -> dict[str, str | int]:
    response_body = urlopen(CONTRIBUTORS_URL).read().decode('utf-8')
    return json.loads(response_body)


def _parse_contributors(
    github_data: dict[str, str | int],
) -> Iterator[Contributor]:
    for contributor in github_data:
        yield {
            'github_login': contributor['login'],
            'github_avatar_url': contributor['avatar_url'],
            'contribution_count': contributor['contributions'],
        }


def _dump_as_json(data: list[Contributor]) -> str:
    return json.dumps(data, indent=2, sort_keys=True)


if __name__ == '__main__':
    main()
