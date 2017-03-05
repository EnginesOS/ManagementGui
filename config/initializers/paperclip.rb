# Add content type for .pem certificates
Paperclip.options[:content_type_mappings] = {
  # pem: 'application/x-x509-ca-cert',
  pem: 'text/plain'
}
