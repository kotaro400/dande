var hiddenFile = document.getElementsByClassName("hidden-file")[0]

hiddenFile.addEventListener("change", function(){
  var file = this.files[0]
  var reader = new FileReader()
  reader.readAsDataURL(file)
  reader.onload = function(){
    var image = this.result
    var prevContent = document.getElementsByClassName("prev-content")
    if (prevContent.length === 0) {
      var html = buildHTML(image)
      document.getElementsByClassName("prev-contents")[0].insertAdjacentHTML('afterbegin', html)
    } else{
      document.getElementsByClassName("prev-image")[0].src = image
    }
  }
})

function buildHTML(image) {
  var html =
    `
    <div class="prev-content">
      <img src="${image}" class="prev-image">
    </div>
    `
  return html;
}
