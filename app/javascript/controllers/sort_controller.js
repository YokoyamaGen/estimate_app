import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { column: String }

  toggle() {
    const modalUrl = new URL('/documents/modal_index', window.location.origin)
    const currentSort = modalUrl.searchParams.get('sort')
    const currentDirection = modalUrl.searchParams.get('direction') || 'asc'
    
    let newDirection = 'asc'
    if (currentSort === this.columnValue && currentDirection === 'asc') {
      newDirection = 'desc'
    }
    
    modalUrl.searchParams.set('sort', this.columnValue)
    modalUrl.searchParams.set('direction', newDirection)
    
    fetch(modalUrl.toString(), {
      headers: {
        'Accept': 'text/vnd.turbo-stream.html'
      }
    })
    .then(response => response.text())
    .then(html => {
      Turbo.renderStreamMessage(html)
    })
  }
}