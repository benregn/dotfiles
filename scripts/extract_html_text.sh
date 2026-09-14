#!/bin/bash

# HTML Text Extractor using CLI tools
# Usage: ./extract_html_text.sh <directory> <selector> [output_file]

set -euo pipefail

# Function to display usage
usage() {
    cat << EOF
Usage: $0 <directory> <selector> [output_file]

Extract text from HTML files using CSS selectors and output structured JSON.

Arguments:
    directory    Directory containing HTML files
    selector     CSS selector (e.g., '[data-testid="description"]')
    output_file  Optional output JSON file (prints to stdout if not specified)

Examples:
    $0 downloaded_html '[data-testid="description"]'
    $0 ./html_files 'p.content' results.json
    $0 docs 'h1, h2' headings.json

Requirements:
    - htmlq (HTML parser): brew install htmlq
    - jq (JSON processor): brew install jq
EOF
}

# Check if required tools are installed
check_dependencies() {
    local missing_tools=()

    if ! command -v htmlq &> /dev/null; then
        missing_tools+=("htmlq")
    fi

    if ! command -v jq &> /dev/null; then
        missing_tools+=("jq")
    fi

    if [ ${#missing_tools[@]} -ne 0 ]; then
        echo "Error: Missing required tools: ${missing_tools[*]}"
        echo "Install with: brew install ${missing_tools[*]}"
        exit 1
    fi
}

# Extract text from a single HTML file
extract_from_file() {
    local file="$1"
    local selector="$2"
    local filename=$(basename "$file")

    # Use htmlq to extract text, handle errors gracefully
    local texts
    if texts=$(htmlq "$selector" --text < "$file" 2>/dev/null); then
        # Convert text lines to JSON array, handling empty results
        local text_array
        if [ -n "$texts" ]; then
            text_array=$(echo "$texts" | jq -R -s 'split("\n") | map(select(length > 0))')
        else
            text_array="[]"
        fi

        # Create JSON object for this file
        jq -n \
            --arg filename "$filename" \
            --arg selector "$selector" \
            --argjson texts "$text_array" \
            '{
                ($filename): {
                    selector: $selector,
                    text_count: ($texts | length),
                    texts: $texts
                }
            }'
    else
        # Handle error case
        jq -n \
            --arg filename "$filename" \
            --arg selector "$selector" \
            --arg error "Failed to parse HTML or selector not found" \
            '{
                ($filename): {
                    selector: $selector,
                    error: $error,
                    text_count: 0,
                    texts: []
                }
            }'
    fi
}

# Main function
main() {
    # Check arguments
    if [ $# -lt 2 ] || [ $# -gt 3 ]; then
        usage
        exit 1
    fi

    local directory="$1"
    local selector="$2"
    local output_file="${3:-}"

    # Check dependencies
    check_dependencies

    # Validate directory
    if [ ! -d "$directory" ]; then
        echo "Error: Directory not found: $directory"
        exit 1
    fi

    # Find HTML files
    local html_files=()
    while IFS= read -r -d '' file; do
        html_files+=("$file")
    done < <(find "$directory" -maxdepth 1 -type f \( -name "*.html" -o -name "*.htm" \) -print0)

    if [ ${#html_files[@]} -eq 0 ]; then
        echo "No HTML files found in $directory"
        echo "{}"
        exit 0
    fi

    echo "Processing ${#html_files[@]} HTML files..." >&2

    # Process each file and collect results
    local temp_files=()
    local counter=0

    for file in "${html_files[@]}"; do
        local temp_file=$(mktemp)
        temp_files+=("$temp_file")

        echo "Processing $(basename "$file")..." >&2
        extract_from_file "$file" "$selector" > "$temp_file"

        counter=$((counter + 1))
    done

    # Merge all JSON objects into one
    local merged_json
    if [ ${#temp_files[@]} -eq 1 ]; then
        merged_json=$(cat "${temp_files[0]}")
    else
        merged_json=$(jq -s 'add' "${temp_files[@]}")
    fi

    # Clean up temp files
    rm -f "${temp_files[@]}"

    # Output results
    if [ -n "$output_file" ]; then
        echo "$merged_json" > "$output_file"
        echo "Results saved to: $output_file" >&2
    else
        echo "$merged_json"
    fi

    # Print summary
    local total_files=$(echo "$merged_json" | jq 'length')
    local successful_files=$(echo "$merged_json" | jq '[.[] | select(.error == null)] | length')
    local total_texts=$(echo "$merged_json" | jq '[.[] | .text_count] | add // 0')

    echo "" >&2
    echo "Summary:" >&2
    echo "Files processed: $total_files" >&2
    echo "Successfully processed: $successful_files" >&2
    echo "Total texts extracted: $total_texts" >&2
}

# Run main function
main "$@"
