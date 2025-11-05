function initMD () {
  // moblie nav toggle
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

  // collection stream show-all toggles
  const toggleSections = document.querySelectorAll('[data-collection-stream="toggle"]')
  toggleSections.forEach((section) => {
    const button = section.querySelector('[data-collection-toggle]')
    if (!button) return

    const initialLimitRaw = section.dataset.initialLimit || '0'
    const initialLimit = Math.max(parseInt(initialLimitRaw, 10) || 0, 0)
    const allItems = Array.from(section.querySelectorAll('[data-collection-item]'))

    const hiddenItems = allItems.slice(initialLimit)
    if (hiddenItems.length === 0) {
      button.hidden = true
      return
    }

    const expandLabel = button.dataset.expandLabel || 'Show All'
    const collapseLabel = button.dataset.collapseLabel || 'Show Less'

    const setExpanded = (expanded) => {
      hiddenItems.forEach((item) => {
        item.classList.toggle('is-hidden', !expanded)
      })
      button.textContent = expanded ? collapseLabel : expandLabel
      button.setAttribute('aria-expanded', String(expanded))
    }

    setExpanded(false)

    button.addEventListener('click', () => {
      const isExpanded = button.getAttribute('aria-expanded') === 'true'
      setExpanded(!isExpanded)
    })
  })
}
document.addEventListener('DOMContentLoaded', initMD)
