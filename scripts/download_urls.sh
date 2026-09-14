#!/bin/bash

# =============================================================================
# URL HTML Downloader with Browser Simulation
# =============================================================================
#
# This script downloads HTML content from a list of URLs while simulating
# browser behavior to avoid being blocked by web servers. It includes rate
# limiting and proper error handling.
#
# USAGE:
#   ./download_urls.sh <url_file>
#
# EXAMPLES:
#   ./download_urls.sh urls.txt
#   ./download_urls.sh my_links.txt
#   ./download_urls.sh /path/to/urls.txt
#
# URL FILE FORMAT:
#   Create a text file with one URL per line:
#
#   https://example.com
#   https://github.com/user/repo
#   https://stackoverflow.com/questions/123456
#   # This is a comment - will be ignored
#   https://news.ycombinator.com
#
#   Empty lines and lines starting with # are ignored.
#
# FEATURES:
#   - Browser simulation with realistic User-Agent and headers
#   - Rate limiting (configurable wait time between requests)
#   - Automatic retry on failures
#   - Safe filename generation from URLs
#   - Progress tracking and status reporting
#   - Error handling with cleanup of failed downloads
#   - Organized output in dedicated directory
#   - Support for redirects and compressed responses
#
# CONFIGURATION:
#   Modify these variables at the top of the script:
#   - WAIT_TIME: seconds to wait between requests (default: 2)
#   - OUTPUT_DIR: directory for downloaded files (default: downloaded_html)
#   - User-Agent string and other headers in the curl command
#
# OUTPUT:
#   - HTML files saved to OUTPUT_DIR with sanitized filenames
#   - Filenames generated from URLs (domain_path_etc.html)
#   - Progress and error messages printed to terminal
#
# ALTERNATIVE APPROACHES:
#
# 1. GNU Parallel (faster for many URLs):
#    If you have GNU parallel installed (brew install parallel):
#
#    # Sequential with delay (recommended for rate limiting)
#    cat urls.txt | parallel -j1 --delay 2 \
#        'curl -s -L --compressed --max-time 30 \
#         -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36" \
#         -o "downloaded_html/{#}_{/.}.html" {}'
#
#    # Parallel with limited concurrency (use carefully)
#    cat urls.txt | parallel -j3 --delay 1 \
#        'curl -s -L --compressed --max-time 30 \
#         -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36" \
#         -o "downloaded_html/{#}_{/.}.html" {}'
#
# 2. wget alternative:
#    wget --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36" \
#         --wait=2 --random-wait --limit-rate=200k \
#         --input-file=urls.txt --directory-prefix=downloaded_html
#
# 3. Simple curl loop (basic version):
#    while read url; do
#        curl -s -A "Mozilla/5.0..." -o "output_$(date +%s).html" "$url"
#        sleep 2
#    done < urls.txt
#
# PARALLEL PROCESSING NOTES:
#   - GNU parallel is more efficient for large numbers of URLs
#   - Use -j1 --delay for sequential processing with rate limiting
#   - Use -j3 --delay for limited parallelism (3 concurrent downloads)
#   - Be careful with parallel downloads - some servers may block aggressive behavior
#   - Consider using --random-wait or variable delays for better stealth
#   - Monitor your network and respect robots.txt and rate limits
#
# TROUBLESHOOTING:
#   - If downloads fail, check URL validity and network connectivity
#   - Some sites may block even with browser headers - try different User-Agent strings
#   - Increase WAIT_TIME if you're getting rate limited
#   - Check the downloaded HTML files for error pages or blocking messages
#   - Use --verbose flag with curl (add -v) for debugging connection issues
#
# DEPENDENCIES:
#   - curl (pre-installed on macOS)
#   - Basic Unix utilities (sed, wc, stat, mkdir)
#   - Optional: GNU parallel for alternative processing methods
#
# =============================================================================

# Check if URL file is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <url_file>"
    echo "Example: $0 urls.txt"
    exit 1
fi

URL_FILE="$1"
OUTPUT_DIR="${OUTPUT_DIR:-downloaded_html}"
WAIT_TIME="${WAIT_TIME:-2}"  # seconds between requests

# Check if URL file exists
if [ ! -f "$URL_FILE" ]; then
    echo "Error: URL file '$URL_FILE' not found"
    exit 1
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Counter for files
counter=1

echo "Starting download process..."
echo "URLs will be saved to: $OUTPUT_DIR/"
echo "Wait time between requests: ${WAIT_TIME} seconds"
echo "----------------------------------------"

# Read URLs from file
while IFS= read -r url || [ -n "$url" ]; do
    # Skip empty lines and comments
    if [[ -z "$url" || "$url" =~ ^[[:space:]]*# ]]; then
        continue
    fi

    # Clean up URL (remove whitespace)
    url=$(echo "$url" | xargs)

    # Generate filename from URL
    filename=$(echo "$url" | sed 's|https\?://||' | sed 's|/|_|g' | sed 's|[^a-zA-Z0-9._-]|_|g')

    # If filename is too long or empty, use counter
    if [ ${#filename} -gt 100 ] || [ -z "$filename" ]; then
        filename="page_$counter"
    fi

    # Add .html extension
    filename="${filename}.html"
    filepath="$OUTPUT_DIR/$filename"

    echo "[$counter] Downloading: $url"
    echo "    -> Saving to: $filename"

    # Download with curl, simulating a browser
    curl -s \
        --user-agent "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" \
        --header "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" \
        --header "Accept-Language: en-US,en;q=0.5" \
        --header "Accept-Encoding: gzip, deflate" \
        --header "Connection: keep-alive" \
        --header "Upgrade-Insecure-Requests: 1" \
        --compressed \
        --location \
        --max-time 30 \
        --retry 2 \
        --retry-delay 1 \
        --output "$filepath" \
        "$url"

    # Check if download was successful
    if [ $? -eq 0 ] && [ -s "$filepath" ]; then
        file_size=$(stat -f%z "$filepath" 2>/dev/null || echo "unknown")
        echo "    ✓ Success (${file_size} bytes)"
    else
        echo "    ✗ Failed"
        # Remove empty file if created
        [ -f "$filepath" ] && rm "$filepath"
    fi

    counter=$((counter + 1))

    # Wait before next request (skip wait for last URL)
    if [ $counter -le $(wc -l < "$URL_FILE") ]; then
        echo "    Waiting ${WAIT_TIME} seconds..."
        sleep $WAIT_TIME
    fi

    echo ""
done < "$URL_FILE"

echo "Download process completed!"
echo "Files saved in: $OUTPUT_DIR/"
