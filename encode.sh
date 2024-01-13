#!/bin/bash

# Define SVG file location
svg_file="./mb2024.svg"

# Use base64 to encode file
encoded_svg=$(base64 < $svg_file | tr -d '\n')

# Print the encoded SVG
echo "data:image/svg+xml;base64,$encoded_svg" > encoded.txt