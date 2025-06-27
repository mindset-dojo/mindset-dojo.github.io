function initMD () {
  // moblie nav toggle
  const body = document.querySelector('body')
  const navMenuToggle = document.querySelector('header button')
  navMenuToggle.addEventListener('click', function () {
    body.classList.toggle('md-no-scroll')
    this.ariaExpanded = this.ariaExpanded !== 'true'
  })
}
document.addEventListener('DOMContentLoaded', initMD)
