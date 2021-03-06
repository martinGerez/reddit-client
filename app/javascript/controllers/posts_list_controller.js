import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['dissmissAll', 'list', 'fetchNewPosts', 'card', 'dissmissLink', 'detail', 'status'];

  dissmiss(event) {
    event.preventDefault();
    const element = event.target;
    const id = element.dataset.id;

    element.closest('.card').classList.add('dissmissed')

    if (id) {
      fetch(`/posts/${id}/dissmiss`, {
        credentials: 'same-origin',
        method: 'PATCH',
        headers: {
          'X-CSRF-Token': this.getMetaValue('csrf-token')
        }
      });
    }
  }

  dissmiss_all(event) {
    event.preventDefault();

    this.cardTargets.forEach(e => e.classList.add('dissmissed'))

    fetch('/posts/dissmiss_all', {
      credentials: 'same-origin',
      method: 'PATCH',
      headers: {
        'X-CSRF-Token': this.getMetaValue('csrf-token')
      }
    });
  }

  async fetch_new_posts(event) {
    event.preventDefault();

    const response = await fetch('/posts/new_posts');

    if (response) {
      const json = await response.json();
      this.listTarget.innerHTML = json.html;
    }
  }

  async show_detail(event) {
    event.preventDefault();
    const id = event.target.dataset.id;
    const indexOfStatusTarget = this.statusTargets.map(e => e.dataset.id).indexOf(id);
    const statusTarget = this.statusTargets[indexOfStatusTarget];

    if (statusTarget) {
      statusTarget.innerHTML = "Status: <b>Read</b>"
    }

    if(id) {
      try {
        const response  = await fetch(`/posts/${id}`);
        const json      = await response.json();

        this.detailTarget.innerHTML = json.html;
      } catch (e) {
        alert(`Error: ${e}`)
      }
    }
  }

  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`)
    return element.getAttribute("content")
  }
}
