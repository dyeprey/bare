# Robot Simulator

A simple Ruby program that simulates a toy robot moving on a 6/6 square grid.

1. **Clone the repository:**
   ```bash
   git clone
   cd testbare
   ```

2. **Install dependencies:**
   ```bash
   bundle install
   ```

## Usage

### Running the Program
```bash
ruby robot.rb
```

### Running Tests
```bash
bundle exec rspec
```

## Commands

- `PLACE X,Y,ORIENTATION` - Place the robot at position (X,Y) facing ORIENTATION
  - ORIENTATION must be one of: `N`, `E`, `S`, `W`
- `MOVE` - Move the robot one step forward in its current direction
- `LEFT` - Turn the robot 90 degrees counter-clockwise
- `RIGHT` - Turn the robot 90 degrees clockwise
- `REPORT` - Display current position and orientation

## Examples

### Basic Movement
```
PLACE 0,0,NORTH
MOVE
MOVE
RIGHT
MOVE
REPORT
```
**Output:** `1, 2, E`

### Edge Case - Robot Won't Fall
```
PLACE 0,0,SOUTH
MOVE
REPORT
```
**Output:** `0, 0, S` (robot ignores the move command)
