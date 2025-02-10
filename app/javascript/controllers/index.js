import { Application } from "@hotwired/stimulus"
import ImageCropperController from "./image_cropper_controller"
import NavbarController from "./navbar_controller"
import FiltersController from "./filters_controller"
import NotificationController from "./notification_controller"

const application = Application.start()

// Configure Stimulus development experience
application.debug = true  // Enable debug mode temporarily
window.Stimulus = application

// Register controllers explicitly
application.register("image-cropper", ImageCropperController)
application.register("navbar", NavbarController)
application.register("filters", FiltersController)
application.register("notification", NotificationController)

// Add any future controllers to the register list above

export { application }