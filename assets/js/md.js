function initMD () {
  // mobile nav toggle
  const body = document.querySelector('body')
  const navMenuToggle = document.querySelector('header button[aria-controls="Menu"]')
  if (navMenuToggle) {
    navMenuToggle.addEventListener('click', function () {
      const currentlyExpanded = this.getAttribute('aria-expanded') === 'true'
      const nextExpanded = !currentlyExpanded
      body.classList.toggle('md-no-scroll', nextExpanded)
      this.setAttribute('aria-expanded', String(nextExpanded))
    })
  }
}
document.addEventListener('DOMContentLoaded', initMD)
