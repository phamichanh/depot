# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.delete_all

Product.create!(
    title: 'Programming Ruby 1.9 & 2.0',
    description:
        %{<p>
            Ruby is the fastest growing and most exciting dynamic language
            out there. If you need to get working programs delivered fast,
            you should add Ruby to your toolbox.
          </p>},
    image_url: 'ruby.jpg',
    price: 49.99)

Product.create!(
    title: 'Agile Web Development with Rails 5.1',
    description:
        %{<p>
            Learn Rails the way the Rails core team recommends it,
            along with the tens of thousands of developers who have used this broad,
            far-reaching tutorial and reference. If you're new to Rails, you'll get step-by-step guidance.
            If you're an experienced developer, get the comprehensive,
            insider information you need for the latest version of Ruby on Rails.
            The new edition of this award-winning classic is completely updated for Rails 5.1 and Ruby 2.4,
            with information on system testing, Webpack, and advanced JavaScript.
          </p>},
    image_url: 'agileruby.jpg',
    price: 39.99)

Product.create!(
    title: 'Code Complete: A Practical Handbook of Software Construction, Second Edition',
    description:
        %{<p>
            Widely considered one of the best practical guides to programming,
            Steve McConnell’s original CODE COMPLETE has been helping developers write better software for more than a decade.
            Now this classic book has been fully updated and revised with leading-edge practices—and hundreds of
            new code samples—illustrating the art and science of software construction.
          </p>},
    image_url: 'codecomplete.jpg',
    price: 45.99)