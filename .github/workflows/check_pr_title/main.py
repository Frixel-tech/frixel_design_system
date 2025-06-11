import sys
import re

TITLE_FORMAT_REGEX = re.compile(
    r"^(feat|fix|docs|ops|test|refacto|perf|style|scaffold)\([^\)]+\)( - .+)?$",
    re.IGNORECASE,
)

ERROR_STATUS = 1

VALID_PR_TAGS = {
    "feat",
    "fix",
    "docs",
    "ops",
    "test",
    "refacto",
    "perf",
    "style",
    "scaffold",
}


def check_pr_title_tags(title: str) -> None:
    """Make sure PR title has valid tags."""

    pr_title_tag_match = re.search(
        r" (feat|fix|docs|ops|test|refacto|perf|style|scaffold)\(", title, re.IGNORECASE
    )
    if not pr_title_tag_match:
        print(
            f"🚫 Pull Request title contains no valid tag. Allowed tags are: {VALID_PR_TAGS}"
        )
        exit(ERROR_STATUS)

    pr_title_tag = pr_title_tag_match.group(1).lower()
    if pr_title_tag not in VALID_PR_TAGS:
        print(
            f"🚫 Pull Request title contains invalid tag: [{pr_title_tag}]. Allowed tags are: {VALID_PR_TAGS}"
        )
        exit(ERROR_STATUS)


def check_pr_title_length(title: str) -> None:
    """Make sure PR title is descriptive enough."""

    if len(title) <= 10:
        print(
            f"🚫 Pull Request title is too short, please add more description (> 40 characters)!: {title}"
        )
        exit(ERROR_STATUS)


def check_pr_title_format(title: str) -> None:
    """Make sure the PR format is correct."""

    if TITLE_FORMAT_REGEX.match(title) is None:
        print(
            f"🚫 Bad Pull Request title detected. It should respect the following format:"
        )
        print(
            "{feat|fix|docs|ops|test|refacto|perf|style}(description of the functionality) [optional: - additional details]."
        )
        exit(ERROR_STATUS)


def main(title: str) -> None:
    """Main function."""

    print(f"Checking your Pull Request title: {title} ⏳")
    check_pr_title_format(title)
    check_pr_title_tags(title)
    check_pr_title_length(title)
    print("🎉 Your Pull Request title looks good! Well Done! 😏")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("🚫 Please provide a Pull Request title to validate.")
        exit(ERROR_STATUS)
    main(sys.argv[1])
