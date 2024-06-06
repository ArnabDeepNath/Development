document.addEventListener('DOMContentLoaded', () => {
  const counters = document.querySelectorAll('.count');
  const speed = 600; // The lower the speed, the faster the count-up

  const countUp = (counter) => {
    const updateCount = () => {
      const target = +counter.getAttribute('data-target');
      const count = +counter.innerText;
      const increment = target / speed;

      if (count < target) {
        counter.innerText = Math.ceil(count + increment);
        setTimeout(updateCount, 1);
      } else {
        counter.innerText = target;
      }
    };

    updateCount();
  };

  // Count-up when the section is in view
  const observer = new IntersectionObserver(
    (entries, observer) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target
            .querySelectorAll('.count')
            .forEach((counter) => countUp(counter));
          observer.unobserve(entry.target); // Unobserve after counting up
        }
      });
    },
    { threshold: 0.1 },
  );

  const countUpSection = document.getElementById('count-up');
  observer.observe(countUpSection);
});

document.addEventListener('DOMContentLoaded', () => {
  const dynamicText = document.getElementById('dynamic-text');
  const phrases = [
    'Software developers',
    'Data Optimizers',
    'Security Managers',
    'Cloud experts',
    'IT consultants',
  ];
  let currentIndex = 0;

  const updateText = () => {
    dynamicText.classList.add('fade-out');

    setTimeout(() => {
      dynamicText.textContent = phrases[currentIndex];
      dynamicText.classList.remove('fade-out');
      dynamicText.classList.add('fade-in');
      currentIndex = (currentIndex + 1) % phrases.length;
    }, 500); // Match this with the transition duration in CSS
  };

  setInterval(updateText, 1000); // Change text every 2.5 seconds to account for the fade out/in
});
