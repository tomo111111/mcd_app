function comment(){
  const btns = document.querySelectorAll(".comment_btn")
  btns.forEach(function(btn){
    btn.addEventListener("click",()=>{
      const btnId = btn.getAttribute("data-id");
      console.log(btnId)
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
        <div class="comment_field" >
          <div>
            ${comment.date}
          </div>
          <div>
            ${comment.text}
          </div>
        </div>`;
          place.insertAdjacentHTML("afterbegin",HTML);
        })
        
      }
    });
  });

}

window.addEventListener("load",comment);