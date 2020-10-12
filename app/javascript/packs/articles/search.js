const add = document.getElementById("add-article")
const form = document.getElementById("article-search")
const right = document.getElementsByClassName("right-content")[0]


add.addEventListener("click", function(){
  switch (add.textContent) {
    case "もどる":
      form.style.display = "none"
      right.style.display = "block"
      document.getElementById("add-article").textContent = "記事を追加"
      break;
    case "記事を追加":
      if (document.getElementById("tag-search")) {
        document.getElementById("tag-search").remove()
      }
      right.style.display = "none"
      form.style.display = "block"
      document.getElementById("add-article").textContent = "もどる"
      break;
  }
})
