import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  connect() {
    console.log('Modal controller connected')
  }

  async open() {
    console.log('Modal open method called')
    console.log('URL:', this.urlValue)
    
    try {
      const response = await fetch(this.urlValue)
      const html = await response.text()
      console.log('Fetched HTML:', html.substring(0, 200))
      
      const modalContainer = document.getElementById('modal-container')
      if (!modalContainer) {
        console.error('Modal container not found')
        return
      }
      
      modalContainer.innerHTML = html
      
      // Bootstrapが読み込まれるまで待機
      if (typeof bootstrap !== 'undefined') {
        const modalElement = document.getElementById('documentsModal')
        if (modalElement) {
          console.log('Creating bootstrap modal')
          const modal = new bootstrap.Modal(modalElement)
          modal.show()
        } else {
          console.error('Modal element not found')
        }
      } else {
        console.error('Bootstrap is not loaded')
      }
    } catch (error) {
      console.error('Error loading modal:', error)
    }
  }
}