# Node Build Image

A minimal docker image tested in AWS Amplify to build and package Node.js applications.
This image contains the necessary dependencies and tools required to build and test Node.js applications.

When a user deploys a Node.js application using AWS Amplify, the platform uses the Node Build Image to create a containerized environment that includes all the required packages and dependencies. This containerized environment is then used to build and package the application, allowing it to be deployed to the specified environment.

The Node Build Image includes popular Node.js tools and libraries with its latest LTS versions:
- npm
- yarn
- Node.js

This image also includes additional dependencies that are commonly required for building and testing Node.js applications:

- Git
- curl
- Python

Overall, the Node Build Image is a convenient and reliable way for AWS Amplify users to build and deploy Node.js applications, without having to worry about configuring the necessary build tools and dependencies themselves.
