var eyeBall = document.querySelector('#eyeBall');
var container = document.querySelector('#container');

container.onmousemove = (event) => {
  var x =
    ((event.clientX - container.offsetLeft) * 100) / container.offsetWidth +
    '%';
  var y =
    ((event.clientY - container.offsetTop) * 100) / container.offsetHeight +
    '%';
  eyeBall.style.transition = '0s';
  eyeBall.style.left = x;
  eyeBall.style.top = y;
};

document.onmouseout = (event) => {
  eyeBall.style.transition = '0.7s';
  eyeBall.style.left = '50%';
  eyeBall.style.top = '50%';
};
