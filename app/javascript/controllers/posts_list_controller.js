import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['card', 'dissmissLink'];

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

    fetch('/posts/#{}/dissmiss', {
      credentials: 'same-origin',
      method: 'PATCH',
      headers: {
        'X-CSRF-Token': this.getMetaValue('csrf-token')
      }
    });
  }

  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`)
    return element.getAttribute("content")
  }
}
