#!python
"""
generate_schema.py

Usage:
    # Single input JSON file
    ./generate_schema.py --input config.json --output config.schema.json

    # All JSON files in a directory
    ./generate_schema.py --input examples/ --output merged.schema.json
"""

import argparse
import json
import os
from genson import SchemaBuilder  # pip install genson

def collect_json_files(path):
    """Return a list of JSON file paths under path (file or directory)."""
    if os.path.isfile(path):
        return [path]
    files = []
    for entry in os.listdir(path):
        full = os.path.join(path, entry)
        if os.path.isfile(full) and entry.lower().endswith(".json"):
            files.append(full)
    return files

def build_schema(input_paths):
    """Build a JSON schema from the given list of JSON files."""
    builder = SchemaBuilder()
    builder.add_schema({ "$schema": "http://json-schema.org/draft-07/schema#" })
    for p in input_paths:
        with open(p, 'r', encoding='utf-8') as f:
            data = json.load(f)
            builder.add_object(data)
    return builder.to_schema()

def main():
    parser = argparse.ArgumentParser(description="Generate JSON Schema from JSON file(s)")
    parser.add_argument("-i", "--input", required=True,
                        help="Input JSON file or directory")
    parser.add_argument("-o", "--output", required=True,
                        help="Output JSON Schema file")
    args = parser.parse_args()

    paths = collect_json_files(args.input)
    if not paths:
        print(f"No JSON files found in {args.input}")
        return

    schema = build_schema(paths)
    with open(args.output, 'w', encoding='utf-8') as out:
        json.dump(schema, out, indent=2)
    print(f"Schema written to {args.output}")

if __name__ == "__main__":
    main()
