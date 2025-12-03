const express = require('express');
const app = express();
const PORT = 3000;

// The Health Check Endpoint (Crucial for AWS ALB)
app.get('/health', (req, res) => {
  res.status(200).send('Healthy');
});

// Main App Logic
app.get('/', (req, res) => {
  res.send('<h1>v1.0 - Blue Environment</h1><p>Welcome to the zero-downtime demo.</p>');
});

app.listen(PORT, () => {
  console.log(`App running on port ${PORT}`);
});