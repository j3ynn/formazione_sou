# Tris

An implementation of the Tic-Tac-Toe game written in Bash, using Docker containers to manage the state of each cell.

## Description

The project simulates a Tic-Tac-Toe game using 9 Docker containers, each representing a single cell of the game grid.

Each container stores its state inside the file `/stato.txt`. The main script coordinates the game by reading and updating these files using `docker exec` commands.

## Requirements

- Bash
- Docker installed and running
- Alpine image (automatically pulled if not present)

## Launch

Make the script executable:

```bash
chmod +x tris.sh
Run the game:
./tris.sh
Game Rules
Two players: X and O
Each turn, a player selects a position from 1 to 9:
1 | 2 | 3
---------
4 | 5 | 6
---------
7 | 8 | 9
A cell cannot be selected if it is already occupied.
The first player to complete a row, column, or diagonal wins.
If all cells are filled without a winner, the game ends in a draw.
Architecture
9 Docker containers (cells1 ... cells9)
Each container contains a file:
/stato.txt -> cell state (-, X, O)
Communication between the script and containers is handled using docker exec.
Game Flow
The program handles:
Input validation (numbers from 1 to 9)
Cell occupation check
State update
Win condition check
Draw condition check
Turn alternation
Cleanup
At the end of execution, all containers are automatically stopped and removed.
