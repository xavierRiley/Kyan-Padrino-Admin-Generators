say "Creating News Section", :green

run "padrino g model NewsArticle title:string tagline:string body_mce:text photo_img:string publication_date:date publish:boolean"
run "padrino rake ar:migrate"
run "padrino g kyan_admin_page NewsArticle"
