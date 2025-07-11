import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = ["checkin", "checkout"]

  connect() {
    flatpickr(this.checkinTarget, {
      minDate: new Date().fp_incr(1),
      onChange: (selectedDates, dateStr, instance) => {
        this.triggerCheckoutDatePicker(selectedDates);
      },
    });
  }

  triggerCheckoutDatePicker(selectedDates){
    flatpickr(this.checkoutTarget, {
      minDate: new Date(selectedDates).fp_incr(1),
      onChange: (selectedDates, dateStr, instance) => {
      },
    });

    this.checkoutTarget.click();
  }
}
