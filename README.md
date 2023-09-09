# Core_Data

Simulator Demo
:-------------------------:
https://github.com/GovindSen0915/Core_Data/assets/85836893/421e16fd-bffb-4556-8d35-ea8638560a9d

- **UserListViewController:**
  - Manages a list of users displayed in a table view.
  - Fetches user data from a database using the `DatabaseManager`.
  - Supports adding new users and updating existing users.
  - Allows users to swipe to delete or update user entries.
  - Displays a list of users with their names, emails, and profile images.

- **RegisterViewController:**
  - Provides a form for adding or updating user details.
  - Allows users to select a profile image from the device's photo library.
  - Validates user input and displays alerts for missing information.
  - Saves user data and profile images to the device's local storage.
  - Supports both user registration and user profile updates.

- **UserCell:**
  - A custom table view cell for displaying user information.
  - Shows the user's full name, email, and profile image.
  - Profile images are displayed with rounded corners.

- **UserModel:**
  - A struct representing user data, including first name, last name, email, password, and profile image name.

- **DatabaseManager:**
  - Manages interactions with Core Data for user data storage.
  - Provides methods for adding, updating, fetching, and deleting user records.
  - Handles the saving and deletion of user profile images from the device's storage.

These classes work together to create a basic user management system, allowing users to view, add, update, and delete user records with associated profile images. The application uses Core Data for local data storage and provides a simple user interface for managing user information.

