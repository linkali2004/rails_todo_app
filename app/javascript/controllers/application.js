import { Application } from "@hotwired/stimulus"
import consumer from "channels/consumer"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
application.consumer = consumer
window.Stimulus   = application

export { application }


document.addEventListener("customevent",(e)=>{
window.location.href = e.detail.toString();
})

document.addEventListener('turbo:stream:created', function(event) {
    alert("gi");
   document.getElementById("form-textfield").value = ""
  });