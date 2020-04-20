# Referance a file
resource "aws_iam_policy" "my_policy" {
  name = "my-bucket-policy"
  user = "rsk-user"
  policy = file("test_policy")
}


data "template_file" "test_hello" {
  template = file("test.tpl")

  vars {
    name = "Santosh",
  }


  # Interpolation to get value will be
  val = data.template_file.test_hello.rendered

}