# MonitorDevices-Server

## Requirements

Before running the application locally, make sure you have the following prerequisites installed:

- **Node.js**: Ensure you have Node.js installed on your machine. You can download it from [nodejs.org](https://nodejs.org/).
- Ensure that all necessary dependencies are installed using `npm install` before executing any commands.

## Getting Started

To run the application locally, follow the steps below:

1. **Compile TypeScript**: Navigate to the project directory in your terminal and run:
    ```
    npx tsc
    ```

2. **Copy Environment File**: Copy the `.env` file to the `transpiled/bin/` directory using the following command:
    ```
    cp .env transpiled/bin/
    ```

3. **Run Migration and Start**: Execute the following command to migrate the database and start the application:
    ```
    npm run migrate && npm run pm2
    ```

## Running the Application with start.sh

For a more streamlined setup and start process, you can use the provided `start.sh` script. This script automates several setup tasks, including setting environment variables, ensuring persistent volumes are correctly configured, and starting the core application. Follow these steps to use `start.sh`:

1. **Make a database directory in your $HOME**
    ```
    mkdir -p $HOME/monitordevices/sqlite/databases
    ```

2. **Ensure Script Permissions**: Before running `start.sh`, ensure it has the appropriate permissions by executing the following command in your terminal:
    ```
    chmod u+x start.sh
    ```

3. **Run start.sh**: Execute the script from your project's root directory:
    ```
    ./start.sh
    ```