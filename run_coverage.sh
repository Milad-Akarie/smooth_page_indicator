#!/bin/bash

# Test Coverage Script for smooth_page_indicator
# This script runs Flutter tests with coverage and generates a report

set -e

echo "🧪 Running Flutter tests with coverage..."
echo "============================================"

# Clean previous coverage data
rm -rf coverage

# Run tests with coverage
flutter test --coverage

echo ""
echo "📊 Coverage data generated!"
echo "============================================"

# Check if lcov is installed
if command -v lcov &> /dev/null; then
    echo "📈 Generating HTML coverage report..."

    # Generate HTML report
    genhtml coverage/lcov.info -o coverage/html --quiet

    echo ""
    echo "✅ HTML coverage report generated at: coverage/html/index.html"
    echo ""

    # Open the report in the default browser (macOS)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "🌐 Opening coverage report in browser..."
        open coverage/html/index.html
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "🌐 Opening coverage report in browser..."
        xdg-open coverage/html/index.html
    fi
else
    echo ""
    echo "⚠️  lcov is not installed. To generate HTML reports:"
    echo "   macOS: brew install lcov"
    echo "   Linux: sudo apt-get install lcov"
    echo ""
    echo "📄 Raw coverage data is available at: coverage/lcov.info"
fi

echo ""
echo "📋 Coverage Summary:"
echo "============================================"

# Show coverage summary if lcov is available
if command -v lcov &> /dev/null; then
    lcov --summary coverage/lcov.info 2>/dev/null || true
else
    # Alternative: show line count from lcov.info
    if [ -f coverage/lcov.info ]; then
        total_lines=$(grep -c "^DA:" coverage/lcov.info 2>/dev/null || echo "0")
        covered_lines=$(grep "^DA:" coverage/lcov.info 2>/dev/null | grep -v ",0$" | wc -l || echo "0")
        if [ "$total_lines" -gt 0 ]; then
            percentage=$((covered_lines * 100 / total_lines))
            echo "Lines: $covered_lines / $total_lines ($percentage%)"
        fi
    fi
fi

echo ""
echo "🎉 Done!"

