# Conversion to pixel
# Project Name

## Overview
This project is a web application that converts images that users drag and drop into pixel images.

## Features
- **Image Upload**: Drag-and-drop functionality for easy image upload.
- **Converted Image Save**: Users can save the converted images after processing.
- **User Authentication**: Registration and login functionality to ensure only authorized users can save images.
- **Usage Limits**: Users are limited to 30 conversions per hour.
- **Infrastructure**: Hosted on Azure App Service, images are stored in Azure Blob Storage, and user/converted image data is managed in Azure SQL Database.

## System Architecture

### Architecture Overview

- **Frontend**:  
  Provides a drag-and-drop UI for image upload and conversion. The frontend is built with modern JavaScript frameworks (React or Vue.js) and hosted on Azure App Service.

- **Backend**:  
  The backend is powered by **Node.js**, which handles the logic for processing image conversion requests. The backend is responsible for invoking a **Python service** to perform image transformations (such as pixelating and adding grid lines). The Node.js backend also manages user authentication, image upload, and metadata handling.

- **Python Service**:  
  A **Python service** is used for image transformation. The backend communicates with this service to perform pixelation and grid-line addition using Python libraries such as **Pillow**. The service is hosted on Azure App Service or as a containerized application in Azure.

- **Database**:  
  User data and metadata for converted images are stored in **Azure SQL Database**. This includes user accounts, image conversion counts, and references to the converted image files.

- **Storage**:  
  Converted images are stored in **Azure Blob Storage**. After the image transformation is completed by the Python service, the backend stores the resulting image in Blob Storage and returns a URL or path to the client.

- **Hosting**:  
  Both the frontend and backend are hosted on **Azure App Service**. The backend is built with **Node.js** using **Express.js** to handle API requests, including image upload, transformation requests, and metadata storage.

- **Logging and Monitoring**:  
  **Azure App Insights** is used to monitor backend performance, track errors, and provide insights into application usage, including user behavior and system resource consumption.

### User Authentication
- Implement account registration and login functionality.
- Only registered users can access the image save feature.

### Specifications
#### Frontend
- Drag-and-drop image upload functionality.
- After upload, users can click a convert button to process the image.
- Display a preview of the converted image, and allow users to save it.

#### Backend
- Provide an API for image conversion.
- Save converted images to Azure Blob Storage.
- Enforce conversion limits based on user authentication.

#### Database
- Store user data (username, email, hashed password) in Azure SQL Database.
- Store metadata for converted images (URL, conversion time) in the database.

#### Usage Limits
- Users can convert images up to **30 times per hour**.
- If the limit is exceeded, an error message will be displayed.

## Infrastructure
- **Azure App Service** for hosting both frontend and backend.
- **Azure Blob Storage** for storing converted images.
- **Azure SQL Database** for managing user and image data.
- **Azure App Insights** for error tracking and monitoring resource usage.
