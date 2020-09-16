function memo() {
  const submit = document.getElementById("submit");
  submit.addEventListener("click", (e) => {
    

    // メモ投稿機能
    const formData = new FormData(document.getElementById("form"));
    const XHR = new XMLHttpRequest();
    XHR.open("POST", "/comments", true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      const comment = XHR.response.post;
      const place = document.getElementById("comment_wrapper");
      const formText = document.getElementById("content");
      const HTML =`
        <div class="comment_field">
          <div>
            <p>${comment.date}</p>
          </div>
          <div class="text_destroy">
            <div class="comment_text">
              <p>${comment.text}</p>
            </div>
            <div class="destroy_link btn btn-outline-secondary btn-sm" id="destroy_btn" data-id=${comment.id}>
              削除
            </div>
          </div>
        </div>`;
      place.insertAdjacentHTML("afterbegin", HTML);
      formText.value = "";



    };
    e.preventDefault();
  });
  
}
window.addEventListener("load", memo);