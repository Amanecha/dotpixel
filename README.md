# Conversion to Pixel

## Project Plan

### Overview
This project aims to develop a web application that allows users to convert images into pixel art through a drag-and-drop interface. The project is currently in the planning and development phase.

### Goals
- **Image Upload Functionality**: Implement a drag-and-drop interface for users to upload images.
- **Image Conversion and Save**: Provide a feature for users to convert images and save the processed results.
- **User Authentication**: Enable user registration and login functionality to restrict certain features, such as image saving, to authorized users only.
- **Usage Limits**: Introduce a feature to limit users to 30 conversions per hour.
- **Infrastructure Setup**: Use Azure services for hosting, storage, and database management.

## Planned System Architecture

### Architecture Overview

- **Frontend**:  
  - Build a user interface for image upload and conversion.  
  - Use modern JavaScript frameworks like **React** or **Vue.js**.  
  - Host the frontend on **Azure App Service**.

- **Backend**:  
  - Develop an API using **Node.js** and **Express.js** for image processing and user authentication.  
  - Integrate with a **Python service** for performing image transformations (e.g., pixelation and grid-line addition).  
  - Host the backend on **Azure App Service**.

- **Python Service**:  
  - Create a Python-based service to handle image transformation using libraries like **Pillow**.  
  - Plan to deploy the service as part of the backend or as a standalone containerized application on Azure.

- **Database**:  
  - Use **Azure SQL Database** to store user data, conversion metadata, and usage logs.

- **Storage**:  
  - Save processed images in **Azure Blob Storage** for scalable and secure storage.  
  - Return URLs of the stored images to users after processing.

- **Hosting and Monitoring**:  
  - Use **Azure App Insights** to monitor application performance, track errors, and gather usage analytics.

## Development Features

- **User Authentication**:  
  - Implement account registration and login.  
  - Restrict the ability to save converted images to authenticated users.

- **Image Upload and Conversion**:  
  - Create a drag-and-drop interface for uploading images.  
  - Add functionality to display and save converted images.

- **Usage Limits**:  
  - Implement backend logic to restrict image conversions to 30 per user per hour.  
  - Notify users when they reach the limit.

## Infrastructure Goals

- **Azure App Service**: Host the frontend, backend, and Python service.
- **Azure Blob Storage**: Store converted images securely.
- **Azure SQL Database**: Manage user accounts and conversion metadata.
- **Azure App Insights**: Monitor application performance and gather analytics.
