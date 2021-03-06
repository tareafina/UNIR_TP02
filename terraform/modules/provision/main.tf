resource "null_resource" "conf" {

  connection {
    type        = "ssh"
    host        = "${var.bastion_host}"
    private_key = file("${path.module}/keys/id_rsa")
    user        = "${var.vm_os_user}"

  }
  provisioner "file" {
    source      = "../ansible"
    destination = "/tmp"
  }
  provisioner "file" {
    source      = "./files"
    destination = "/tmp/ansible"
  }
    provisioner "remote-exec" {
    inline = [
      "sudo bash /tmp/ansible/init.sh"
    ]

  }

  provisioner "remote-exec" {
    inline = [
"bash /tmp/ansible/ansible.sh ${var.priv_ip} apps apps"
    ]

  }
}