# Task Management App

This project is a Task Management application developed using Flutter, employing the principles of Clean Architecture. The application allows users to efficiently manage their tasks with features to add, delete, and toggle the completion status of each task.

## Architecture

The project is structured around **Clean Architecture**, which promotes separation of concerns and ensures that the codebase is scalable and maintainable. This architectural approach helps in organizing the code into layers, making it easier to test and develop further.

## State Management

State management is handled using **BLoC (Business Logic Component)**, providing a clear separation between the UI and business logic. This approach allows for a reactive programming style, making the application responsive to user inputs and data changes.

## Local Data Storage

Currently, the application stores data locally for each session. This means that tasks can be added, modified, and deleted during the app's runtime. However, once the app is closed, the data will not persist.

## Features

- Add new tasks
- Delete existing tasks
- Toggle task completion status (mark as complete or incomplete)
