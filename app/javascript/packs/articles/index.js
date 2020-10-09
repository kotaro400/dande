var contentsList = document.getElementById('idx');
var div = document.createElement('div');

var matches = document.querySelectorAll('.article .trix-content h1');
var ul = document.createElement('ul');

matches.forEach(function (value, i) {
  var id = value.id;
  if(id === '') {
    id = `heading_${i + 1}`;
    value.id = id;
  }

  if(value.tagName === 'H1' && value.textContent) {
    var li = document.createElement('li');
    var a = document.createElement('a');

    a.innerHTML = value.textContent;
    a.href = location.pathname + "#" + value.id;
    a.dataset.turbolinks = false
    li.appendChild(a)
    ul.appendChild(li);
    div.appendChild(ul);
  }

  contentsList.appendChild(div);
})

var close = document.getElementById("close-idx")

close.addEventListener("click", function(){
  document.getElementById("idx-wrapper").style.display = "none"
})

if (window.matchMedia && window.matchMedia('(max-width: 768px)').matches) {
  const hamburger = document.getElementById("hamburger")

  hamburger.addEventListener("click", function(){
    document.getElementById("idx-wrapper").style.display = "block"
  })
}
