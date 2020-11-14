if (window.matchMedia && window.matchMedia('(max-width: 768px)').matches) {
  const hamburger = document.getElementById("hamburger")
  const closeSearch = document.getElementById("close-search")

  hamburger.addEventListener("click", function(){
    document.getElementsByClassName("search-content")[0].style.display = "block"

    document.getElementsByClassName("columns-wrapper")[0].children[0].style.display = "none"
  })

  closeSearch.addEventListener("click", function(){
    document.getElementsByClassName("search-content")[0].style.display = "none"

    document.getElementsByClassName("columns-wrapper")[0].children[0].style.display = "block"
  })
}
