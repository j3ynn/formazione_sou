# ExBonus - Bash Scripting Exercises

This folder contains bonus exercises assigned outside the main track, focused on Bash scripting, data structures, and control flow.

---

## Exercise 1 - Log Analysis (accessi.txt)

### Problem

A corporate server experienced an anomalous traffic spike. The file `accessi.txt` contains one IP address per line, representing each connection made to the server. Many IP addresses appear multiple times.

The goal is to analyze `accessi.txt` and extract the 3 most frequent IP addresses, showing the number of occurrences and the IP itself, ordered from most to least frequent.

### Solution

```bash
sort accessi.txt | uniq -c | sort -nr | head -3
```

### Explanation

- `sort accessi.txt` — reads the file and sorts the lines alphabetically, grouping identical IPs together
- `uniq -c` — counts consecutive duplicate lines and prepends the count to each unique line
- `sort -nr` — sorts numerically (`-n`) in descending order (`-r`) based on the count
- `head -3` — shows only the top 3 results

### Expected Output

```
3 192.168.1.10
2 10.0.0.5
2 1.2.3.4
```

---

## Exercise 2 - CPU Metrics Analysis (analizza_metriche.sh)

### Problem

The file `metriche.txt` contains 100 lines of data, each with a server name and a CPU usage percentage. The goal is to calculate the average CPU usage per server.

### Setup

Before running the analysis, generate the `metriche.txt` file by running:

```bash
bash generatore_log.sh
```

Bug fix in generatore_log.sh

The original script provided contained an intentional error: a semicolon (;) immediately after the done keyword, followed by > "$FILE_OUTPUT". This caused the output file to be emptied after the loop completed, resulting in an empty metriche.txt.

bash# Original (broken)
done ; > "$FILE_OUTPUT"

# Fixed
done > "$FILE_OUTPUT"

Removing the semicolon ensures the output redirection applies to the entire loop, not as a separate command that overwrites the file after the loop finishes.

```

### Explanation

- `declare -A CPU` and `declare -A OCCORRENZA` — declare two associative arrays (key-value pairs, like dictionaries) to store the total CPU usage and the occurrence count per server
- `while IFS= read -r riga` — reads the file line by line; `IFS=` preserves whitespace, `-r` treats backslashes as literal characters
- `awk '{print $1}'` and `awk '{print $2}'` — extract the first and second field (server name and CPU value) from each line
- `(( CPU[$server] += utilizzo ))` — accumulates the total CPU usage for each server
- `(( OCCORRENZA[$server] ++ ))` — increments the occurrence counter for each server
- `for server in "${!CPU[@]}"` — iterates over all unique server keys found in the array
- `media=$(( CPU[$server] / OCCORRENZA[$server] ))` — calculates the integer average (Bash integer division)
