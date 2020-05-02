# Start a container
resource "docker_container" "santy" {
  name  = "northern"
  image = docker_image.light.latest
}

# Find the latest Ubuntu precise image.
resource "docker_image" "light" {
  name = "santoshr1016/lights"
}
