# activeecord-blockwhere

Simply conditions DSL for ActiveRecord.
It helps using Arel Predications in the block.

## Installation

Add this line to your application's Gemfile:

    gem 'activerecord-blockwhere'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activerecord-blockwhere

## Usage

    # * person has many entries.
    # Person(id: integer, name: string)
    # Entry(id: integer, person_id: integer, name: string)
    
    Person.where { id.eq(1) }.to_sql
    # => SELECT "people".* FROM "people"  WHERE "people"."id" = 1
    
    Person.where { !id.eq(1) }.to_sql
    # => SELECT "people".* FROM "people"  WHERE (NOT ("people"."id" = 1))
    
    Person.where { id.eq(1) & name.matches('%alice%') }.to_sql
    # => SELECT "people".* FROM "people"  WHERE ("people"."id" = 1 AND "people"."name" LIKE '%alice%')
    
    Person.where { id.in([1,2,3]) & name.not_eq('bob') }.to_sql
    # => SELECT "people".* FROM "people"  WHERE ("people"."id" IN (1, 2, 3) AND "people"."name" != 'bob')
    
    Person.where { name.eq('alice') | name.eq('bob') }.to_sql
    # => SELECT "people".* FROM "people"  WHERE (("people"."name" = 'alice' OR "people"."name" = 'bob'))
    
    # join association
    Person.where { name.eq('alice') & entries.name.matches('%hello%') }.to_sql
    # => SELECT "people".* FROM "people"
    #    INNER JOIN "entries" ON "entries"."person_id" = "people"."id"
    #    WHERE ("people"."name" = 'alice' AND "entries"."name" LIKE '%hello%')

    # in action method
    def index
      # you can use controller's method in the block. ex: params,request,etc..
      # but cannot use instance variables.
      @person = Person.where { id.eq(params[:id]) }.first
    end

## Introductory articles

* [techscore blog (in Japanese)](http://www.techscore.com/blog/2013/05/08/activerecord-blockwhere/ "techscore")

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
