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

  // related content toggles
  const relatedSections = document.querySelectorAll('[data-related-toggle="true"]')
  relatedSections.forEach((section) => {
    const buttons = Array.from(section.querySelectorAll('[data-related-toggle-button]'))
    const content = section.querySelector('[data-related-toggle-content]')
    if (buttons.length === 0 || !content) return

    const showLabel = buttons[0].dataset.showLabel || 'Show'
    const hideLabel = buttons[0].dataset.hideLabel || 'Hide'

    const setExpanded = (expanded) => {
      content.hidden = !expanded
      buttons.forEach((btn) => {
        btn.textContent = expanded ? hideLabel : showLabel
        btn.setAttribute('aria-expanded', String(expanded))
      })
    }

    setExpanded(false)

    buttons.forEach((btn) => {
      btn.addEventListener('click', () => {
        const expanded = btn.getAttribute('aria-expanded') === 'true'
        setExpanded(!expanded)
      })
    })
  })

  // card filters
  const cardFilters = document.querySelectorAll('[data-card-filter]')
  cardFilters.forEach((filter) => {
    const section = filter.closest('section')
    if (!section) return
    const grid = section.querySelector('[data-card-grid]')
    if (!grid) return

    const buttons = Array.from(filter.querySelectorAll('[data-card-filter-button]'))
    const items = Array.from(grid.querySelectorAll('[data-card-item]'))
    if (buttons.length === 0 || items.length === 0) return

    const setFilter = (tag) => {
      items.forEach((item) => {
        const tags = (item.dataset.tags || '').split(/\s+/)
        const match = tag === 'all' || tags.includes(tag)
        item.classList.toggle('is-hidden-by-filter', !match)
      })
    }

    buttons.forEach((button) => {
      button.addEventListener('click', () => {
        const tag = button.dataset.tag || 'all'
        buttons.forEach((btn) => btn.classList.toggle('is-active', btn === button))
        setFilter(tag)
      })
    })

    setFilter('all')
  })
}
document.addEventListener('DOMContentLoaded', initMD)
