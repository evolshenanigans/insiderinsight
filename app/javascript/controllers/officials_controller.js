import { Controller } from "stimulus"

export default class extends Controller {
  select(event) {
    const officialId = event.currentTarget.dataset.officialIdParam;
    // Now, use this `officialId` to update the content
    // This can be done by fetching partials from Rails and updating the DOM
    this.updatePhoto(officialId);
    this.updateStockList(officialId);
    this.updateInfo(officialId);
  }

  updatePhoto(officialId) {
    // Example: Fetch and update the official's photo
    fetch(`/photos/${officialId}`)
      .then(response => response.text())
      .then(html => {
        document.querySelector("#official-photo").innerHTML = html;
      });
  }

  updateStockList(officialId) {
    // Fetch and update the stock list for the official
    fetch(`/stocks/${officialId}`)
      .then(response => response.text())
      .then(html => {
        document.querySelector("stock-list").innerHTML = html;
      });
  }

  updateInfo(officialId) {
    // Fetch and update the info for the official
    fetch(`/info/${officialId}`)
      .then(response => response.text())
      .then(html => {
        document.querySelector("info-section").innerHTML = html;
      });
  }
}
