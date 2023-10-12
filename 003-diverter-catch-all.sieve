require ["include", "environment", "variables", "relational",  "fileinto"];

# set user variables
set "catchall_email"  "catchall@yourdomain.fart";
set "catchall_label"  "none";
set "catchall_folder" "Admin/Invalid";

# sort and filter emails sent to non-existent addresses on custom domain
if header :contains "Delivered-To" "${catchall_email}" {
  fileinto "${catchall_label}";
  fileinto "${catchall_folder}";  
  stop;
}
