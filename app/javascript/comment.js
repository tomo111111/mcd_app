function comment(){
  const btns = document.querySelectorAll(".comment_btn")
  btns.forEach(function(btn){
    btn.addEventListener("click",()=>{

      //フォームを表示
      const form = document.getElementById("comment_form");
      form.removeAttribute("class","hidden");

      const btnId = btn.getAttribute("data-id");
      console.log(btnId)
      // クリックされたボタンのbtnIdから日付を計算して隠し要素のvalueにセット。
      const today = new Date();
      const intId = parseFloat(btnId);
      const dateData = today.setDate(today.getDate() - 7 + intId)
      // console.log(dateData);
      const date = document.getElementById("hidden_date");   
        date.setAttribute("value",`${dateData}`);
        
      const XHR = new XMLHttpRequest();
      XHR.open("GET",`/comments/${btnId}`,true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        const comments = XHR.response.com;
        const place = document.getElementById("comment_wrapper");
        const addHTML = document.getElementsByClassName("comment_field");
        while (addHTML.length) {
          
          addHTML.item(0).remove()
        }
        comments.forEach(function(comment){
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
          place.insertAdjacentHTML("afterbegin",HTML);
        })

        //コメント有無によるボタンの切り替え
        const submit = document.getElementById("submit");
        // console.log(btn);
        // console.log(addHTML.length);
        submit.addEventListener("click", () => {
          
          const checkLength = function(){
            if (addHTML.length){ 
            btn.removeAttribute("class","fa-plus-square");
            btn.setAttribute("class","far fa-comment-dots comment_btn");
            };
          };
          setTimeout(checkLength,100);
        });


      }
    });
  });

}

window.addEventListener("load",comment);