provider "docker" {}

resource "docker_image" "rs_image_name" {
  name = "santoshr1016/lights:latest"
}

resource "docker_container" "rs_container_name" {
  name = "lights_tf"
  image = docker_image.rs_image_name.latest
  ports {
    internal = "80"
    external = "9000"
  }
}