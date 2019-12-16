import {Controller} from 'stimulus';

export default class extends Controller {
  static targets = ['commentList', 'text', 'notice', 'alert'];

  //Handler for comment add
  add(event) {
    let xhr = event.detail[2];
    this.commentListTarget.innerHTML += xhr.response.trim();
    this.textTarget.value = '';

    this.displaySuccess('Comment successfully added');
  }

  //Handler for comment edit
  //Tempted to pre-render edit forms and toggle them on instead of going to server to get them.
  //But will leave as is - getting the form from the server, and ghiding list item.
  edit(event) {
    let xhr = event.detail[2];
    let currentComment = event.target.parentElement;
    let newComment = currentComment.cloneNode(true);

    currentComment.style.display = 'none';
    newComment.innerHTML = xhr.response.trim();
    this.commentListTarget.insertBefore(newComment, currentComment);
  }

  //Restore previous list element if edit is cancelled - bring back hidden list item
  cancelEdit(event) {
    event.preventDefault();
    let currentComment = event.target.parentElement.parentElement;
    let hiddenComment = currentComment.nextSibling;

    this.commentListTarget.removeChild(currentComment);
    hiddenComment.style.display = 'list-item';
  }

  //Handler for comment update
  update(event) {
    let xhr = event.detail[2];
    let currentComment = event.target.parentElement;
    let hiddenComment = currentComment.nextSibling;

    this.commentListTarget.removeChild(currentComment);
    hiddenComment.insertAdjacentHTML('afterend', xhr.response.trim());
    this.commentListTarget.removeChild(hiddenComment);

    this.displaySuccess('Comment successfully updated');
  }

  //Handler for comment delete
  delete(event) {
    let currentComment = event.target.parentElement;
    this.commentListTarget.removeChild(currentComment);

    this.displaySuccess('Comment successfully deleted');
  }

  displaySuccess(text) {
    this.alertTarget.innerHTML = '';
    this.noticeTarget.innerHTML = text;
  }

  //Handler for any errors
  displayErrors(event) {
    this.noticeTarget.innerHTML = '';
    let xhr = event.detail[2];
    this.alertTarget.innerHTML = xhr.response.trim();
  }
}