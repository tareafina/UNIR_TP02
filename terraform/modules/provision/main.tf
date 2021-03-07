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
"bash /tmp/ansible/${var.provision_script} ${var.priv_ip} ${var.hostname} ${var.host_role}"
    ]

  }
}
