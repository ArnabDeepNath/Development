var line = document.querySelector('#line');
var container = document.querySelector('#container');
var centerX = container.offsetWidth / 2;
var centerY = container.offsetHeight / 2;

container.onmousemove = (event) => {
  var xDiff = event.clientX - container.offsetLeft - centerX * 0.01;
  var yDiff = event.clientY - container.offsetTop - centerY * 0.01;

  var x = centerX + xDiff + 'px';
  var y = centerY + yDiff + 'px';

  line.style.transition = '0s';
  line.style.top =
    Math.min(Math.max(0, yDiff + centerY), container.offsetHeight - 1) + 'px';
  line.style.left =
    Math.min(Math.max(0, xDiff + centerX), container.offsetWidth - 1) + 'px';
};

container.onmouseout = (event) => {
  line.style.transition = '0.7s';
  line.style.top = centerY + 'px';
  line.style.left = centerX + 'px';
};
