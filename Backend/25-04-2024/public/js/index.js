document.addEventListener('DOMContentLoaded', function () {
  const startButton = document.querySelector('.product_btn');
  const wishInput = document.querySelector('#Product input[type="text"]');
  const timeInput = document.querySelectorAll('#Product input[type="text"]')[1];
  const timerDisplay = document.createElement('div');
  timerDisplay.classList.add('timer_display');
  document.querySelector('#Product').appendChild(timerDisplay);

  let startTime;
  let timerInterval;

  startButton.addEventListener('click', function () {
    const wish = wishInput.value;
    const time = parseInt(timeInput.value);

    if (!isNaN(time) && time > 0) {
      startTime = Date.now();
      localStorage.setItem('startTime', startTime);
      localStorage.setItem('wish', wish);
      localStorage.setItem('time', time);

      startTimer(time);
    } else {
      alert('Please enter a valid time in seconds');
    }
  });

  function startTimer(duration) {
    timerInterval = setInterval(function () {
      const elapsed = Math.floor((Date.now() - startTime) / 1000);
      const remaining = duration - elapsed;

      if (remaining <= 0) {
        clearInterval(timerInterval);
        timerDisplay.textContent =
          "Time's up! You can fullfil the wish of " +
          localStorage.getItem('wish') +
          'Now';
        localStorage.removeItem('startTime');
        localStorage.removeItem('wish');
        localStorage.removeItem('time');
      } else {
        timerDisplay.textContent = 'Time remaining: ' + remaining + ' seconds';
      }
    }, 1000);
  }

  // Check if there's a timer running when the page loads
  if (localStorage.getItem('startTime')) {
    const elapsed = Math.floor(
      (Date.now() - parseInt(localStorage.getItem('startTime'))) / 1000,
    );
    const remaining = parseInt(localStorage.getItem('time')) - elapsed;
    if (remaining > 0) {
      startTimer(remaining);
    } else {
      localStorage.removeItem('startTime');
      localStorage.removeItem('wish');
      localStorage.removeItem('time');
    }
  }
});
