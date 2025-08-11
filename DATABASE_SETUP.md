# OculoCheck Database Setup with phpMyAdmin

This guide will help you set up the MySQL database for the OculoCheck mobile app using phpMyAdmin.

## Prerequisites

1. **XAMPP, WAMP, or MAMP** installed on your computer
2. **phpMyAdmin** accessible (usually at `http://localhost/phpmyadmin`)
3. **Flutter** development environment set up

## Step 1: Start Your Local Server

1. Start XAMPP/WAMP/MAMP
2. Start Apache and MySQL services
3. Open phpMyAdmin in your browser: `http://localhost/phpmyadmin`

## Step 2: Create the Database

### Option A: Using the SQL Script (Recommended)

1. In phpMyAdmin, click on the **"SQL"** tab
2. Copy and paste the contents of `database_setup.sql` file
3. Click **"Go"** to execute the script

### Option B: Manual Creation

1. Click **"New"** in the left sidebar
2. Enter database name: `oculocheck`
3. Select collation: `utf8mb4_unicode_ci`
4. Click **"Create"**

## Step 3: Verify Database Setup

After running the script, you should see:

### Tables Created:
- **`users`** - Stores user information
- **`tests`** - Stores test results

### Table Structure:

#### Users Table:
- `id` (INT, AUTO_INCREMENT, PRIMARY KEY)
- `name` (VARCHAR(100), NOT NULL)
- `lastName` (VARCHAR(100), NOT NULL)
- `age` (INT, NOT NULL)
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

#### Tests Table:
- `id` (INT, AUTO_INCREMENT, PRIMARY KEY)
- `imagePath` (TEXT, NOT NULL)
- `result` (VARCHAR(50), NOT NULL)
- `confidence` (DECIMAL(5,4), NOT NULL)
- `userId` (INT, NOT NULL, FOREIGN KEY)
- `createdAt` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

## Step 4: Configure Flutter App

1. Open `lib/config/database_config.dart`
2. Update the database configuration:

```dart
class DatabaseConfig {
  // Update these values according to your setup
  static const String host = 'localhost';
  static const int port = 3306;
  static const String user = 'root';
  static const String password = ''; // Your MySQL password if set
  static const String database = 'oculocheck';
}
```

## Step 5: Install Dependencies

Run the following command in your Flutter project directory:

```bash
flutter pub get
```

## Step 6: Test the Connection

1. Run your Flutter app
2. Check the console output for database connection messages
3. You should see: "Connected to MySQL database: oculocheck"

## Troubleshooting

### Common Issues:

1. **Connection Refused**
   - Make sure MySQL service is running
   - Check if the port (3306) is correct
   - Verify host is 'localhost'

2. **Access Denied**
   - Check username and password in `database_config.dart`
   - Default XAMPP username is 'root' with no password

3. **Database Not Found**
   - Make sure the 'oculocheck' database exists
   - Run the SQL script again if needed

4. **Tables Not Created**
   - Check if the SQL script executed successfully
   - Look for any error messages in phpMyAdmin

### Testing Database Connection:

You can test the connection by adding this code to your app:

```dart
final databaseService = DatabaseService();
bool isConnected = await databaseService.testConnection();
print('Database connected: $isConnected');
```

## Security Considerations

1. **Change Default Password**: If using in production, change the default MySQL password
2. **Environment Variables**: Use environment variables for database credentials in production
3. **Network Security**: Ensure your MySQL server is not exposed to the internet
4. **Backup**: Regularly backup your database

## Sample Data (Optional)

To add sample data for testing, uncomment the sample data section in `database_setup.sql` and run it again.

## Support

If you encounter issues:
1. Check the Flutter console for error messages
2. Verify MySQL service is running
3. Test connection using phpMyAdmin
4. Check database configuration in `database_config.dart`
