const plus = document.getElementById("plus-btn")
const menu = document.getElementById("owner-menu")
const close = document.getElementById("close-menu")

plus.addEventListener("click", function(){
  plus.style.display = "none"
  menu.style.display = "block"
})

close.addEventListener("click", function(){
  plus.style.display = "block"
  menu.style.display = "none"
})
