# Notes App

This is a Flutter and Dart-based notes app that allows users to create, edit, and manage their notes. The app provides two main pages: the Notes List page and the Note Editor page. It supports both Arabic and English languages, offers various customization options through a settings dialog, and is responsive for both landscape and portrait orientations. The app can store the notes in local storage using the `sqflite` package.

## Features

- **Notes List Page:** This page displays all the existing notes in a scrollable list format. Users can perform the following actions:

  - Delete a note by long-pressing on it and then dropping it onto a delete button.
  - Reorder notes based on time.

- **Note Editor Page:** This page enables users to write or edit notes. They can enter the desired content and save it.

- **Localization:** The app supports both Arabic and English languages, providing a localized experience for users.

- **Settings Dialog:** The app includes a settings dialog that offers various customization options, including:

  - Changing font size and color.
  - Customizing the colors of the app bar, background, buttons, and more.

- **Responsive Design:** The app is designed to be responsive and adapt to different screen orientations, supporting both landscape and portrait modes.

- **Local Storage:** The app utilizes the `sqflite` package to store the notes locally, ensuring that the user's notes persist across sessions.
