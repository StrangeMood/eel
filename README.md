# Eel [![Build Status](https://secure.travis-ci.org/StrangeMood/eel.png?branch=master)](https://travis-ci.org/StrangeMood/eel)

This is a small AR extension created to unleash the power of Arel
and make it visually suitable for every day usage.

Examples:
```ruby
# you can use any Arel predicate: eq not_eq gt gteq lt lteq in not_in, etc.
User.where(['age > ?', x]) # AR
User.where(User.arel_table[:age].gt x) # Arel with AR
User.where(:age.gt x) # Eel with AR
```
```ruby
# or you can combine more than one column in one statement
User.where('created_at > updated_at') # AR
User.where(User.arel_table[:created_at].gt(User.arel_table[:updated_at])) # Arel with AR
User.where(:created_at.gt :updated_at.attr) # Eel with AR
```
```ruby
# sql logical operands are acceptable
User.where(['age > ? OR role = ?', x, 'admin']) # AR
User.where(User.arel_table[:age].gt(x).or(User.arel_table[:role].eq('admin'))) # Arel with AR
User.where(:age.gt(x).or(:role.eq 'admin')) # Eel with AR
```

You can see it is just Arel but with a little bit of syntactic sugar.
