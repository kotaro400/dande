var tags = document.querySelectorAll(".delete-tag")

tags.forEach(element => {
  element.addEventListener("click", function(){
    element.parentNode.parentNode.remove()
  })
})
