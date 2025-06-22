import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  perform() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      const formData = new FormData(this.element)
      const searchTerm = formData.get('search')
      
      const url = new URL('/documents/modal_index', window.location.origin)
      if (searchTerm) {
        url.searchParams.set('search', searchTerm)
      }
      
      fetch(url.toString(), {
        headers: {
          'Accept': 'text/vnd.turbo-stream.html'
        }
      })
      .then(response => response.text())
      .then(html => {
        Turbo.renderStreamMessage(html)
      })
    }, 300)
  }
}