import { application } from "./application"
import ImageCropperController from "./image_cropper_controller"
import NavbarController from "./navbar_controller"

application.register("image-cropper", ImageCropperController)
application.register("navbar", NavbarController) 