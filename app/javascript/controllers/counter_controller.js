import ApplicationController from './application_controller.js'

export default class extends ApplicationController {
  changeurl(event) {
    event.preventDefault()
    console.log(event.target)
  }
}