# Connect Four ♦️
![Connect Four Splash screen](https://github.com/user-attachments/assets/c6ba0c37-98e2-45e6-8aa1-4a19a4102ccf)

[Connect Four](https://en.wikipedia.org/wiki/Connect_Four) is a game I enjoyed playing with my friends, now it is available to play right in your terminal. 

[v1.0.0 Gameplay footage](https://youtube.com/shorts/VuAdV_Qhu_s?si=81jbzTuxLqFJLOrS)

## Setup

```bash
# Clone the repository
git clone https://github.com/AncientNimbus/rb-connect-four.git
cd rb-connect-four

# Install dependencies
bundle install

# Run the game
bundle exec ruby main.rb

# Display help
--help

# Quit the program
--ttfn

# Launch Connect four
--play connect4
```



## How to play
![Gameplay pic](https://github.com/user-attachments/assets/d63084f3-fcc3-4083-a87b-da517e25b255)

1. Select a game mode
   1. Mode [1]: Player vs Player
   2. Mode [2]: Player vs Computer (Coming soon!)
2. The game will randomly decide who goes first
3. Player will each take turn to drop a coloured disc into a column
4. To drop the coloured disc, enter a column number between 1 to 7
5. Try to connect four of your discs in a row up and down (vertical), side to side (horizontal), or diagonally
6. The first player to get four of their coloured discs in a row wins! 
   If the whole grid fills up and no one has four in a row, the game is a tie.



## Technical Specifications

**Core Objectives**

- Written with Ruby
- TDD approach
- OOP software architecture

**Additional Objectives**

- UX design for terminal game
- Localisation ready

**Implementation highlights**

- Robust input handling (Butterfingers-proof)
- Mathematical Grid system
- Precomputed Lookup Table
- Win condition detection via `Set`
- Localisation ready via `YAML` configuration file
- Colourful game interface with terminal interface

**Performance Optimisation**

- All possible winning combinations are calculated once at startup
- Validation order: Check recent moves first for faster win detection
- Single formula that handles 6 movement directions

**Error handling**

- User input is validate against Regex pattern
- Warning is displayed when user attampted to add disc to a full row

<details>
  <summary>Screenshot</summary>
   
![connect_four_gameplay_1](https://github.com/user-attachments/assets/e447522a-56a3-4604-894c-d06c5ff7684d)

</details>

### Gems used

- RSpec
- Rubocop
- Colorize
- Yard
