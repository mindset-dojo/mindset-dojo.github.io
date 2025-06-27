function initMD () {
  // moblie nav toggle
  let body = document.querySelector('body');
  let navMenuToggle = document.querySelector('header button');
  navMenuToggle.addEventListener('click', function() {
    body.classList.toggle('md-no-scroll');
    this.ariaExpanded = this.ariaExpanded !== 'true';
  });
}
document.addEventListener('DOMContentLoaded', initMD);
