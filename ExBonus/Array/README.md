Bash String Processing Exercises
This repository contains two different approaches to processing comma-separated strings in Bash. Both scripts perform case normalization (lowercase), deduplication, and alphabetical sorting, but they utilize different methodologies: one focuses on Unix pipelines, while the other implements a manual algorithmic approach.

Exercise 1: Unix Pipeline Approach
File: ex01.sh

Implementation Details

This script follows the Unix philosophy of "doing one thing well" by chaining specialized utilities using pipes.

Logic:

The input string is parsed into a temporary array using a custom IFS (Internal Field Separator).

The printf command outputs each array element on a new line.

tr converts the stream to lowercase.

sort organizes the lines alphabetically.

uniq removes consecutive duplicate entries.

Usage

Bash
chmod +x ex01.sh
./ex01.sh "Apple,Orange,Apple,Banana"
Exercise 2: Algorithmic Approach with Associative Arrays
File: ex02.sh

Implementation Details

This script implements a manual sorting and deduplication logic without relying on sort or uniq binaries. It demonstrates advanced Bash features such as associative arrays and nested loops.

Deduplication: Uses an associative array (declare -A DOPPI) where the string itself acts as the key. Since keys in associative arrays are unique, duplicates are eliminated during assignment.

Ranking Algorithm (Counting Sort):

Iterates through the unique elements.

For each element, a nested loop compares it against all other unique elements to count how many precede it alphabetically.

The count determines the index in the final POSIZIONE array.

Performance Analysis:

Time Complexity: O(n 
2
 ) due to the nested loops used for comparison.

Space Complexity: O(n) to store the associative array keys and the final positions.

Usage

Bash
chmod +x ex02.sh
./ex02.sh "apple,orange,apple,banana"
Technical Requirements
Environment: Unix-like shell (Linux, macOS, WSL).

Version: Bash 4.0 or higher (required for associative array support).

License
MIT License

Option 2: Individual READMEs (If you prefer separate files)
README_EX01.md

Markdown
# Unix Pipeline String Processor

A lightweight Bash script that utilizes standard Unix filters to process strings.

## Methodology
The script leverages `printf`, `tr`, `sort`, and `uniq` in a pipeline. This approach is optimized for development speed and utilizes the highly efficient C-based implementations of standard GNU/BSD utilities.

## Execution
```bash
./ex01.sh "string1,string2,string1"

### README_EX02.md
```markdown
# Algorithmic String Sorting in Bash

A deep-dive into Bash data structures, implementing sorting and deduplication manually.

## Features
- **Associative Arrays**: Used for $O(1)$ average-time deduplication.
- **Nested Iteration**: Manually calculates the rank of each element based on lexicographical comparison.
- **Pure Bash**: Minimizes external process calls, keeping the logic within the shell environment.

## Computational Complexity
- **Time**: $O(n^2)$
- **Space**: $O(n)$
