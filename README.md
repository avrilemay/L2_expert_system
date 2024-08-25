# Expert System for Cat Breed Identification

## Overview

This project is an expert system designed to identify the breed of a cat based on a series of user-provided characteristics. The system operates by asking the user a series of questions related to the cat's physical attributes, such as weight, coat type, and ear shape. Based on the answers, the system determines the most likely breed from a set of predefined rules.

## Project Structure

The project is composed of two main files:

- **SE_12.lisp**: The core of the expert system, containing the logic and functions needed to run the system.
- **SE_12_data.lisp**: This file contains the global variables, basic propositions, and rules used by the expert system to identify cat breeds.

### Key Functions

- **chat**: The main function that drives the expert system. It initializes the data, poses questions to the user, and evaluates the rules to provide the final result.
- **initialisation_prop**: Resets the basic propositions to 'unknown' for each run, allowing the system to be used multiple times without needing to reload the files.
- **init_conclu**: Initializes conclusions to 'nil', resetting the system's conclusions for a fresh run.
- **pose_questions**: Asks the user questions based on the basic propositions and updates the values according to the user's responses.
- **parcourt_regles**: Iterates through the rules to determine which breed conclusions apply based on the user's responses.
- **donne_resultats**: Displays the results to the user, showing the identified breed.

## Usage

To use the expert system, follow these steps:

1. Load the `SE_12.lisp` file in a Lisp environment.
2. The `chat` function will be called automatically, initiating the system.
3. Answer the questions prompted by the system.
4. The system will provide the most likely breed based on your responses.

If you wish to run the system multiple times, simply call the `chat` function again after the initial run.

## Examples

Here are some examples of how the system works:

- When prompted, if the user indicates the cat is alive and is indeed a cat, the result will confirm this as "chat".
- If all answers are negative or unknown, the system will either return an empty result or display "Merci" depending on how the function is called.

## License

This project was developed as part of the Algorithmics and Data Structures course and is provided for educational purposes.

## Author

**Avrile Floro** 
