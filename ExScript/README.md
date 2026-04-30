# Fruit Generator and Counter

## Overview

This project consists of two Bash scripts:

1. **Fruit Generator**: Continuously writes random fruit entries into a text file.
2. **Fruit Counter**: Reads the generated file and counts the occurrences of each fruit.

The scripts demonstrate basic shell scripting concepts such as loops, conditionals, file handling, and text processing with standard Unix utilities.

---

## File Structure

* `generator.sh` – Generates random fruit entries and appends them to `frutta.txt`
* `counter.sh` – Reads `frutta.txt` and prints the count of each fruit
* `frutta.txt` – Output file containing generated data

---

## Requirements

* Bash shell
* Standard Unix utilities: `grep`, `wc`, `tr`, `head`

---

## Script 1: Fruit Generator

### Description

This script runs an infinite loop that generates a random number and appends a corresponding fruit (or an error string) to `frutta.txt` every 2 seconds.

### Behavior

* Generates a random number between 0 and 4
* Maps each number to a fruit or an error message:

  * 0 → apple
  * 1 → pear
  * 2 → banana
  * 3 → grape
  * 4 → error entry
* Appends the result to `frutta.txt`
* Waits 2 seconds before repeating

### Usage

```bash
chmod +x generator.sh
./generator.sh
```

To stop the script, press `Ctrl + C`.

---

## Script 2: Fruit Counter

### Description

This script reads the content of `frutta.txt` and counts how many times each fruit appears.

### Implementation Details

* Uses `grep -o` to extract individual matches
* Pipes results to `wc -l` to count occurrences
* Outputs labeled counts for each fruit

### Output Example

```
mele: 10
pere: 8
banane: 6
uva: 12
```

### Usage

```bash
chmod +x counter.sh
./counter.sh
```

---

## Notes

* The generator script runs indefinitely; consider running it in a separate terminal.
* The counter script assumes that `frutta.txt` already exists and contains data.
* The error entries ("error frutto marcio") are ignored by the counting logic.

---

## Possible Improvements

* Add file size limits or log rotation
* Handle concurrent access to `frutta.txt`
* Extend the counter to include error entries
* Replace infinite loop with configurable iterations
* Improve randomness generation method

---

## License

This project is provided for educational purposes and can be freely modified and distributed.

