# Customising the Padrino admin generator

This is some work I've been doing at [Kyan](http://kyan.com) to streamline starting Padrino projects and creating admin pages.
This repo is meant to be cloned into a `generators` folder in the project root, where it overrides the default Padrino admin to add some convenience features.

I'm using a gist to get things started for each project.

`padrino g project mysuperapp.com --app MySuperApp --template https://gist.github.com/1761898`

Assumes use of postgres, ruby 1.9.2, git, bundler

Once the project has generated use the following steps to generate an admin page

`padrino g model NewsArticle title:string body_mce:text main_img:string publish:boolean sample_file:string position:integer publication_date:datetime`
`padrino rake ar:migrate`
`padrino g kyan_admin_page NewsArticle`

`padrino s`

Visit `http://0.0.0.0:3000/admin`

Use it.


## Naming conventions

Field names with the following endings do special things

`_img` makes an image upload
`_file` makes a file upload
`_date` makes a date selector

A field called `position` will act like a list and allow the model to be ordered

## Relationships

Most of the standard relationships (has one, belongs to etc) are handled by default.

