document.querySelectorAll("#article_content div").forEach(element => {
  var new_element = document.createElement("p")

  new_element.innerHTML = element.innerHTML

  document.getElementById("article_content").replaceChild(
    new_element,
    element
  )
})
