// routes/timer.js
const express = require('express');
const router = express.Router();
const { requireAuth } = require('../middleware/authMiddleware');
const Timer = require('../models/Timer');

router.post('/start-timer', requireAuth, async (req, res) => {
  const { wish, duration } = req.body;
  const startTime = Date.now();
  const userId = req.userId;

  const timer = new Timer({ wish, duration, startTime, userId });
  await timer.save();

  res.status(201).json({ message: 'Timer started successfully' });
});

module.exports = router;
