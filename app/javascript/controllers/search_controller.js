import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
  }

  toggleSearchModal() {
    document.getElementById("search").click();
  }
}
