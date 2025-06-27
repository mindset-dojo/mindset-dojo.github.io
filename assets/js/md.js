function initMD () {
  // moblie nav toggle
  let body = document.querySelector("body");
  let nav_menu_toggle = document.querySelector("header button");
  nav_menu_toggle.addEventListener("click", function() {
    body.classList.toggle("md-no-scroll");
    this.ariaExpanded = this.ariaExpanded !== 'true';
  });
}
document.addEventListener('DOMContentLoaded', initMD);
