function destroy() {

  const btns = document.querySelectorAll(".comment_btn")
  btns.forEach(function(btn){
    
    btn.addEventListener("click",()=>{
       
      const destroyMaker = function(){
        const destroySubmit = document.querySelectorAll("#destroy_btn");
        if (destroySubmit != null){
          console.log(destroySubmit);
          destroySubmit.forEach(function(des){
            const dataId = des.getAttribute("data-id");
            console.log(dataId);
            des.addEventListener("click",(e)=>{

              const XHR = new XMLHttpRequest();
              XHR.open("GET", `/comments/${dataId}/destroy`, true);
              XHR.responseType = "json";
              XHR.send();
              XHR.onload = () => {

                //commentsと同じ 
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
                
                  const checkLength = function(){
                    if (addHTML.length == 0){ 
                    btn.removeAttribute("class","fa-comment-dots comment_btn");
                    btn.setAttribute("class","far fa-plus-square");
                    };
                  };
                  setTimeout(checkLength,100);
                
                // commentsと同じ

              }
              e.preventDefault();
            });
          });
        };
      };
      setInterval(destroyMaker,3000);
    });
  });
}
window.addEventListener("load", destroy);