// backend/config/db.js
require('dotenv').config();
const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  port: process.env.DB_PORT || 3306,
  database: process.env.DB_NAME || 'cashtrace',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  enableKeepAlive: true,
  keepAliveInitialDelay: 0,
  // Use Jakarta timezone (UTC+7) to prevent date shifting
  timezone: '+07:00',
  // Don't convert dates to JavaScript Date objects (keeps them as strings)
  dateStrings: true
});

// Test connection (don't exit on failure - just log error)
const testConnection = async () => {
  try {
    const connection = await pool.getConnection();
    console.log('Database connected successfully');
    connection.release();
  } catch (err) {
    console.error('Database connection error:', err.message);
    console.log('Server will continue running. Please configure database environment variables.');
  }
};

testConnection();

module.exports = pool;