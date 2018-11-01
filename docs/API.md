# Curator API Documentation

## Book

Creating a Book object

```ruby
book = Book.new
book.title = 'Wizard of Oz'
book.title
#=> "Wizard of Oz"

book.authors = ["L. Frank Baum"]
book.authors
#=> ["L. Frank Baum"]

book.subjects = ["Fantasy"]
book.subjects
#=> ["Fantasy"]
```