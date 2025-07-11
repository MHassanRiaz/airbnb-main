import { Controller } from "@hotwired/stimulus"
import {toggle} from 'el-transition'

export default class extends Controller {
  connect () {
  }

  toggleModal(){
    const modalTriggerId = this.element.dataset.modalTriggerId;
    toggle(document.getElementById(`modal-${modalTriggerId}-wrapper`));
  }
}

