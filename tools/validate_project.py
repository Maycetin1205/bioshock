#!/usr/bin/env python3
"""Fast repository checks that do not require a Godot installation."""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TEXT_SUFFIXES = {".gd", ".godot", ".tscn", ".tres", ".md", ".yml", ".yaml"}
RESOURCE_PATTERN = re.compile(r'res://([^"\)]+)')
CLASS_PATTERN = re.compile(r"^class_name\s+(\w+)", re.MULTILINE)


def main() -> int:
    errors: list[str] = []
    registered_classes: dict[str, Path] = {}

    for path in sorted(ROOT.rglob("*")):
        if not path.is_file() or path.suffix not in TEXT_SUFFIXES:
            continue

        relative = path.relative_to(ROOT)
        text = path.read_text(encoding="utf-8")

        if "\r" in text:
            errors.append(f"{relative}: CRLF line endings are not allowed")
        if not text.endswith("\n"):
            errors.append(f"{relative}: missing final newline")
        for line_number, line in enumerate(text.splitlines(), start=1):
            if line.rstrip() != line:
                errors.append(f"{relative}:{line_number}: trailing whitespace")

        for resource_path in RESOURCE_PATTERN.findall(text):
            if not (ROOT / resource_path).exists():
                errors.append(f"{relative}: missing resource res://{resource_path}")

        if path.suffix == ".gd":
            class_match = CLASS_PATTERN.search(text)
            if class_match:
                class_name = class_match.group(1)
                if class_name in registered_classes:
                    errors.append(
                        f"duplicate class_name {class_name}: "
                        f"{registered_classes[class_name]} and {relative}"
                    )
                registered_classes[class_name] = relative

        if path.suffix == ".tscn":
            if not text.startswith("[gd_scene "):
                errors.append(f"{relative}: missing gd_scene header")
            if text.count("[") != text.count("]"):
                errors.append(f"{relative}: bracket count mismatch")

    if errors:
        print("Project validation failed:")
        for error in errors:
            print(f"- {error}")
        return 1

    print(
        f"Project validation passed: "
        f"{len(list(ROOT.rglob('*.gd')))} scripts, "
        f"{len(list(ROOT.rglob('*.tscn')))} scenes, "
        f"{len(registered_classes)} registered classes."
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
