#!/bin/bash

# Function to preview images using chafa
preview_image() {
    local width=$(tput cols)
    local height=$(tput lines)
    chafa --colors=256 --symbols=block --size="${width}x${height}" "$1" 2>/dev/null
}

# Function to preview other file types
preview_other() {
    bat --style=plain --color=always "$1"
}

# Main preview function
main() {
    if file "$1" | grep -qE 'image|bitmap'; then
        preview_image "$1"
    else
        preview_other "$1"
    fi
}

main "$1"

