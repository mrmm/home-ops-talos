resource "local_file" "nodes_yaml" {
  content = templatefile("${path.module}/template/nodes.yaml.tftpl", {
    nodes         = var.nodes
    schematic_id  = talos_image_factory_schematic.this.id
  })

  filename = "${path.module}/../../nodes.yaml"
}
